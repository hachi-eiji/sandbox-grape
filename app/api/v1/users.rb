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
        User.find(params[:id])
      end
    end
  end
end
