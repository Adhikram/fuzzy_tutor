# frozen_string_literal: true

module Api
  module V1
    class PaperElementsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :user_auth
      before_action :problem_setter_auth, only: %i[create update destroy]
  end
end
