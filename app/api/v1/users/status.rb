# frozen_string_literal: true

class V1::Users::Status < Grape::API
  get :status do
    { health: "ok" }
  end
end
