# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include JSONAPI::ActsAsResourceController
      include ApplicationHelper
      before_action :user_auth
      before_action :problem_setter_auth, only: %i[create update destroy]

      def index
        courses = current_user.fetch_courses

        data = courses.map do |course|
          {
            name: course.name,
            description: course.description,
            active_status: course.active_status,
            course_type: course.course_type,
            slug: course.slug,
            updated_at: course.updated_at
          }
        end

        render_success(data: data)
      end

      def show
        active_status = current_user.user_type != 'student' ? [true, false] : true
        course = Course.find_by(slug: params[:id], active_status: active_status)

        return render_error('Course not found') if course.blank?

        render_success(course.slice(*allowed_course_attributes))
      end

      def create
        course = Course.new(course_params)
        course.user_id = current_user.id
        course.slug = "#{course.name.parameterize}-#{Digest::SHA1.hexdigest([Time.now, rand].join)[0, 6]}"

        if course.save
          render_success(course.slice(*allowed_course_attributes))
        else
          render_error(course.errors.full_messages)
        end
      end

      def destroy
        fetch_id_from_slug(Course, :id, :id, params)
        course = Course.find_by(id: params[:id])
        return render_error('Course not found') if course.blank?

        if course.destroy
          render_success(message: 'Course deleted successfully')
        else
          render_error('Failed to delete course')
        end
      end

      def update
        fetch_id_from_slug(Course, :id, :id, params)
        course = Course.find_by(id: params[:id])
        return render_error('Course not found') if course.blank?

        if course.update(course_params)
          render_success(course.slice(*allowed_course_attributes))
        else
          render_error(course.errors.full_messages)
        end
      end

      def active_courses
        courses = if current_user.user_type != 'student'
                    Course.all
                  else
                    Course.where(active_status: true)
                  end

        sorted_courses = courses.order(updated_at: :desc)

        data = sorted_courses.map do |course|
          {
            id: course.id,
            name: course.name,
            description: course.description,
            active_status: course.active_status,
            course_type: course.course_type,
            slug: course.slug,
            updated_at: course.updated_at
          }
        end

        render_success(data: data)
      end

      def papers
        fetch_id_from_slug(Course, :id, :id, params)

        return render_error('Course not found') if params[:id].blank?

        papers = current_user.fetch_papers(params[:id])
        return render_error('Papers not found') if papers.blank?

        render_success(data: papers.map { |paper| paper.slice(*allowed_paper_attributes) })
      end
    end
  end
end
