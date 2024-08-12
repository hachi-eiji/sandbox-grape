# frozen_string_literal: true

module Helpers
  module ErrorHelper
    extend ActiveSupport::Concern

    included do
      rescue_from :all do |e|
        error!(e, 500)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        begin
          name = I18n.t!("activerecord.models.#{e.model.downcase}")
          message = I18n.t!("activerecord.errors.messages.record_not_found", name:)
        ensure
          "データが見つかりません"
        end
        error!(message, 404)
      end

      nested_parameter = Regexp.new(/\A(\w+)\[(\w+)\]\z/)
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        attribute_keys = self.options[:for].base.name.underscore.split("::").join(".")

        error_messages = e.errors.map do |field, messages|
          field_name = field.first.to_s.split(".").last

          # ネスト内の各要素の正規表現にマッチしているならば,I18で変換できるパターンに変換
          matched = nested_parameter.match(field_name)
          field_name = unless matched.nil?
           matched.captures.join(".")
          else
            field_name
          end

          attributes = I18n.t("grape.errors.attributes.#{attribute_keys}.#{field_name}")

          # ハッシュがとれる時は実際にはネストされている各要素のバリデーション結果がほしいのでスキップ
          if attributes.is_a?(Hash)
            next
          end

          formatted_messages = messages.map do |m|
            I18n.t(attributes:, message: m.message, default: I18n.t("grape.errors.format"))
          end
          formatted_messages
        end
        error!(error_messages.flatten.compact, 400)
      end
    end
  end
end
