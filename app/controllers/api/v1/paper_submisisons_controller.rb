# frozen_string_literal: true

module Api
  module V1
    class PaperSubmisisonsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      include ApplicationHelper
      before_action :user_auth

      def create
        fetch_id_from_slug(Paper, :paper_slug, :paper_id, params)
        paper_submission_params[:submitted_at] = Time.now
        submission = PaperSubmission.new(paper_submission_params)

      end
    end
  end
end
