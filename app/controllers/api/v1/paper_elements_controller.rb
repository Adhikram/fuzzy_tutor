# frozen_string_literal: true

module Api
  module V1
    class PaperElementsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      include ApplicationHelper
      before_action :user_auth
      before_action :problem_setter_auth, only: %i[create update destroy]
      before_action :validate_element_type, only: %i[create update]

      def validate_element_type
        parent = paper_element_params.dig(:parent_id)
        return if parent.blank?

        parent_element = PaperElement.find_by(id: parent)

        return unless parent_element && paper_element_params[:element_type].present?

        if paper_element_params[:element_type] == 'question' && parent_element.element_type == 'section'
          # Disallow question to have a parent section
          render_error("Questions cannot have a parent of type 'section'")
          nil
        elsif paper_element_params[:element_type] == 'answer' && parent_element.element_type in %w[section question]
          # Disallow answer to have a parent section or question
          render_error("Answers cannot have a parent of type 'section' or 'question'")
          nil
        end
      end

      def create
        paper_element = PaperElement.new(paper_element_params)
        if paper_element.save
          render_success(paper_element.slice(*allowed_paper_element_attributes))
        else
          render_error(paper_element.errors.full_messages)
        end
      end

      def update
        paper_element = PaperElement.find(params[:id])

        if paper_element.update(paper_element_params)
          render_success(paper_element.slice(*allowed_paper_element_attributes))
        else
          render_error(paper_element.errors.full_messages)
        end
      end
    end
  end
end
