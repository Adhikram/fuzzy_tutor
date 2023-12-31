# frozen_string_literal: true

module Api
    module V1
      class PaperElementResource < JSONAPI::Resource
        attributes :id, :element_type, :text, :link, :marks, :negative_marks, :meta_data, :created_at, :updated_at, :parent_id, :paper_id
        filter :parent_id
      end
    end
  end