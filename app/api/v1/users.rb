# frozen_string_literal: true

module V1
  class Users < Grape::API
    resource :users do
      get do
        users = User.all
        present users, with: V1::Entities::User, type: 'admin'
      end

      params do
        requires :id, type: Integer, desc: 'User id'
      end
      route_param :id do
        get do
          user = User.find(params[:id])
          present user, with: V1::Entities::User, type: 'admin'
        end
        mount V1::Users::Comments
      end
    end
  end
end
