# frozen_string_literal: true

module Api
    module V1
      class PaperElementResource < JSONAPI::Resource
        attributes :element_type, :text, :link, :marks, :negative_marks, :meta_data, :created_at, :updated_at
      end
    end
  end