# frozen_string_literal: true

module Api
  module V1
    class PapersController < ApplicationController
      include JSONAPI::ActsAsResourceController
      include ApplicationHelper
      before_action :user_auth
      before_action :problem_setter_auth, only: %i[create update destroy]

      def show
        fetch_id_from_slug(Paper, :id, :id, params)

        paper = Paper.find_by(id: params[:id])
        return render_error('Paper not found') if paper.blank? || params[:id].blank?

        render_success(paper.slice(*allowed_paper_attributes))
      end

      def create
        fetch_id_from_slug(Course, :course_slug, :course_id, params['data']['attributes'])
        paper = Paper.new(paper_params)
        paper.user_id = current_user.id

        paper.slug = "#{paper.title.parameterize}-#{Digest::SHA1.hexdigest([Time.now, rand].join)[0, 6]}"
        paper_element = PaperElement.create!(element_type: 0, text: paper.title)
        paper.paper_element_id = paper_element.id

        if paper.save
          paper_element.update(paper_id: paper.id)
          render_success(paper.slice(*allowed_paper_attributes))
        else
          render_error(paper.errors.full_messages)
        end
      end

      def update
        fetch_id_from_slug(Paper, :id, :id, params)
        paper = Paper.find_by(id: params[:id])
        return render_error('Paper not found') if params[:id].blank?

        if paper.update(paper_params)
          render_success(paper.slice(*allowed_paper_attributes))
        else
          render_error(paper.errors.full_messages)
        end
      end

      def destroy
        fetch_id_from_slug(Paper, :id, :id, params)
        paper = Paper.find_by(id: params[:id])

        return render_error('Paper not found') if paper.blank? || params[:id].blank?

        if paper.destroy
          render_success(message: 'Paper deleted successfully')
        else
          render_error('Failed to delete paper')
        end
      end
    end
  end
end
