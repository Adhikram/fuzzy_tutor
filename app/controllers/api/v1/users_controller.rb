# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :user_auth, only: %i[me logout]

      def me
        data = { id: current_user.id, type: 'users' }.merge!(current_user.slice(*allowed_user_attributes))
        render_success(data)
      end

      def create
        if User.find_by(phone: user_params['phone']).present?
          return render_error(message: 'Phone number already exists')
        end
        return render_error(message: 'Email already exists') if User.find_by(email: user_params['email']).present?

        user = User.new(user_params)
        if user.save
          sign_in(user) # Automatically sign in the user after creation
          render_success(user.slice(*allowed_user_attributes))
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        user = if params[:email].blank?
                 User.find_for_database_authentication(phone: params[:phone])
               else
                 User.find_for_database_authentication(email: params[:email])
               end

        if user&.valid_password?(params[:password])
          sign_in(user)
          return render_success(user.as_json) if current_user.present?
        else
          render_unauthorized('Username or password is incorrect')
        end
      end

      def logout
        user = current_user
        sign_out(current_user)
        render_success(id: user.id, type: 'logout', notice: 'You logged out successfully')
      end

      private

      def user_params
        params.require(:data)
              .require(:attributes)
              .permit(:email, :password, :user_type, :phone, :name)
      end

      def allowed_user_attributes
        %i[name email phone user_type created_at updated_at]
      end
    end
  end
end
