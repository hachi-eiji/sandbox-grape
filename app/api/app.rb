# frozen_string_literal: true

class App < Grape::API
  format :json
  prefix :api

  get :health do
    { healthy: true }
  end

  mount V1::Root
end
