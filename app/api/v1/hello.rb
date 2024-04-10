# frozen_string_literal: true

module V1
  class Hello < Grape::API
    resource :hello do
      desc 'hello world'
      get '/' do
        { message: 'hello world' }
      end
    end
  end
end
