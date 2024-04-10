# frozen_string_literal: true

module V1
  class Users < Grape::API
    resource :users do
      get '/' do
        { message: 'hello world' }
      end
    end
  end
end
