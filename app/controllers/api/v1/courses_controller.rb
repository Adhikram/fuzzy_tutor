# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include JSONAPI::ActsAsResourceController
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
        course.slug = "#{course.name.parameterize}_#{Digest::SHA1.hexdigest([Time.now, rand].join)[0, 6]}"

        if course.save
          render_success(course.slice(*allowed_course_attributes))
        else
          render_error(course.errors.full_messages)
        end
      end

      def destroy
        course = Course.find_by(slug: params[:id])
        render_error('Course not found') if course.blank?
        if course.destroy
          render_success(message: 'Course deleted successfully')
        else
          render_error('Failed to delete course')
        end
      end

      def update
        course = Course.find_by(slug: params[:id])
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

      private

      def course_params
        params.require(:data)
              .require(:attributes)
              .permit(:name, :description, :active_status, :course_type)
      end

      def allowed_course_attributes
        %i[name description active_status course_type slug created_at updated_at]
      end
    end
  end
end
