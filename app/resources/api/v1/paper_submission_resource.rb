# frozen_string_literal: true

module Api
  module V1
    class PaperSubmissionResource < JSONAPI::Resource
      attributes :id, :paper_id, :user_id, :score, :metadata, :result_metadata, :is_best_submission, :started_at,
                 :submitted_at, :created_at, :updated_at, :evaluated_at, :slug
      filter :paper_id
      filter :user_id
    end
  end
end
