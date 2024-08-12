# frozen_string_literal: true

require "test_helper"
require "grape"

class DummyAPI < Grape::API
  include ::Helpers::ErrorHelper
  format :json

  namespace :test do
    get do
      { health: "ok" }
    end

    get "error" do
      raise "Something went wrong"
    end

    params do
      requires :id, type: Integer
      requires :name, type: String
      requires :elements, type: Array[Integer], values: 1..10
      requires :comment, type: Hash do
        requires :id, type: Integer
        requires :comment, type: String
        requires :type, type: Array[Symbol], values: [ :best, :good, :bad, :worst ]
      end
    end
    post do
      { params: }
    end
  end
end

module Helpers
  class ErrorHelperTest < Minitest::Test
    include Rack::Test::Methods

    def app
      DummyAPI
    end

    def test_getで200とレスポンスが返る
      get "/test"

      assert_equal({ health: "ok" }, JSON.parse(last_response.body, symbolize_names: true))
      assert_equal(200, last_response.status)
    end

    def test_post_パラメータが正常の場合に200レスポンスとbodyが返る
      params = {
        id: 1,
        name: "your name",
        elements: [ 1, 2 ],
        comment: {
          id: 10,
          comment: "some comment",
          type: [ :best ]
        }
      }
      post("/test", params)

      params[:comment][:type] = [ "best" ]
      assert_equal({ params: }, JSON.parse(last_response.body, symbolize_names: true))
      assert_equal(201, last_response.status)
    end

    def test_post_パラメータが不正の時に400レスポンスとエラーが返る
      params = {
        id: "foo",
        comment: {
          comment: "some comment",
          type: [ :not_found ]
        }
      }
      post("/test", params)

      assert_equal(400, last_response.status)

      error = %w[
        ダミーIDは不正な形式です
        ユーザ名は必須です
        要素は必須です
        要素は無効な値です
        コメントIDは必須です
        コメントタイプは無効な値です
      ]
      assert_equal({ error: }, JSON.parse(last_response.body, symbolize_names: true))
    end

    def test_なにか例外が起きたときに500レスポンスとエラーが返る
      get "/test/error"

      assert_equal(500, last_response.status)
      assert_equal({ error: "Something went wrong" }, JSON.parse(last_response.body, symbolize_names: true))
    end
  end
end
