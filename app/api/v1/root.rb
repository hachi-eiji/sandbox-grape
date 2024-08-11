# frozen_string_literal: true

module V1
  class Root < Grape::API
    version "v1"

    mount V1::Users
  end
end
