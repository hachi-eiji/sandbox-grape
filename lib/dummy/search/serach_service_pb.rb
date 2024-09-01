# frozen_string_literal: true

require 'search/search_pb'

module Search
  class Service
    def self.call
      puts ::Search::Foo
    end
  end
end
