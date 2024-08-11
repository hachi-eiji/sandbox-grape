# frozen_string_literal: true

class V1 < Grape::API
  version "v1"

  mount V1::Users
end
