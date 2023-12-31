# frozen_string_literal: true

module Api
  module V1
    class PaperSubmissionResource < JSONAPI::Resource
      attributes :title, :description, :active_status, :resourse_link, :paper_type, :created_at, :updated_at
    end
  end
end
