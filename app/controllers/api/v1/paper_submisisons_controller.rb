# frozen_string_literal: true

module Api
  module V1
    class PaperSubmisisonsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      include ApplicationHelper
      before_action :user_auth
    end
  end
end
