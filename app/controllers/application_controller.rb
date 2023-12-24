# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApiRenderConcern
  # before_action :set_current_user
  def user_auth
    return true if current_user.present?

    render_unauthorized('You are not authorized to access this page')
  end

  def current_user_auth
    user_id = request.params['id'].to_i
    return true if current_user&.id == user_id

    render_unauthorized
  end

  def problem_setter_auth
    return true if current_user&.user_type != 'student'

    render_unauthorized('You are not authorized to access this page')
  end

  # private

  # def set_current_user
  #   @current_user = User.find(21)
  # end
  protected

  def find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:email)
      where(conditions.to_h).where(['lower(email) = :value OR lower(phone_number) = :value',
                                    { value: login.downcase }]).first
    elsif login = conditions.delete(:phone_number)
      where(conditions.to_h).where(['lower(email) = :value OR lower(phone_number) = :value',
                                    { value: login.downcase }]).first
    end
  end
end
