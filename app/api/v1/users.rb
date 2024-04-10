# frozen_string_literal: true

module V1
  class Users < Grape::API
    resource :users do
      get '/' do
        users = User.all
        present users, with: V1::Entities::User, type: 'admin'
      end
    end
  end
end
