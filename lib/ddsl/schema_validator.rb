# frozen_string_literal: true

require 'json-schema'
require_relative './schema'

module DDSL
  class SchemaValidator
    class InvalidError < StandardError; end

    #
    # Validate given data against DDSL schema. If data is not compliant with the schema,
    # InvalidError will be raised
    #
    # @param [Hash] data
    #
    # @return [Hash] same data that was given
    #
    def validate!(data)
      errors = JSON::Validator.fully_validate(DDSL::SCHEMA, data, version: DDSL::SCHEMA_VERSION)

      raise InvalidError, errors.join('\n') if errors.count.positive?

      data
    end
  end
end