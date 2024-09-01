# frozen_string_literal: true

require 'test/protos/article_pb'

module DataApi
  module Article
    module ArticleId
      class Service
        def self.call
          puts ::DataApi::Article::GetRequest
        end
      end
    end
  end
end
