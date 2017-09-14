module Validations
  module Type
    def self.validate(value, validator_value)
      case validator_value
      when 'string'
        !value.is_a?(::String)
      when 'boolean'
        !(!!value == value)
      when 'number'
        !value.is_a?(::Numeric)
      end
    end  
  end
end
