# frozen_string_literal: true

class V1::Users < Grape::API
  resource :users do
    get do
      User.all
    end

    params do
      requires :id, type: Integer, desc: "User id"
    end
    route_param :id do
      get do
        user = User.find(params[:id])
        present user, with: V1::Entities::User
      end

      mount V1::Users::Status
    end
  end
end
