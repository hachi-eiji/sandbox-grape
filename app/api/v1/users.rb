# frozen_string_literal: true

module V1
  class Users < Grape::API
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

        mount V1::Users::Status
      end
    end
  end
end
