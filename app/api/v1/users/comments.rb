# frozen_string_literal: true

module V1
  class Users::Comments < Grape::API
    resource :comments do
      get do
        HttpClient::HttpGetClient.new.execute
      end
    end
  end
end
