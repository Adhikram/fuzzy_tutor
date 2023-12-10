# frozen_string_literal: true

module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :email, :name, :phone, :user_type, :created_at, :updated_at

      def self.updatable_fields(context)
        super - %i[email phone created_at updated_at]
      end
    end
  end
end
