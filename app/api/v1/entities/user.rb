# frozen_string_literal: true

module V1
  module Entities
    class User < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt&.iso8601 }

      expose :id
      expose :name
      expose :email, if: { type: 'admin' } do |user|
        user.email.upcase
      end
      expose :role, as: :user_role
      with_options(format_with: :iso_timestamp) do
        expose :birthday
        expose :created_at
      end
    end
  end
end
