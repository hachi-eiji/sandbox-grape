# frozen_string_literal: true

class BaseApi < Grape::API
  version :v1
  format :json

  mount V1::Hello
  mount V1::Users
end
