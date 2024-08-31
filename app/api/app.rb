# frozen_string_literal: true

class App < Grape::API
  include ::Helpers::ErrorHelper

  format :json
  prefix :api
  version "v1"

  get :health do
    { healthy: true }
  end

  mount V1::Users
end
