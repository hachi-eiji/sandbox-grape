# frozen_string_literal: true

module V1
  class Users < Grape::API
    resource :users do
      get '/' do
        users = User.all
        present users, with: V1::Entities::User
      end
    end
  end
end
