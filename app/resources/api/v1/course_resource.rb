# frozen_string_literal: true

module Api
  module V1
    class CourseResource < JSONAPI::Resource
      attributes :name, :description, :active_status, :course_type, :slug, :user_id, :created_at, :updated_at
      primary_key :slug
    end
  end
end
