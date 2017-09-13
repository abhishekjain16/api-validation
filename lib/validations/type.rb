module Validations
  module Type
    def self.validate(value, validator_value)
      case validator_value
      when 'string'
        !value.is_a?(String)
      when 'boolean'
        !value.is_a?(Boolean)
      when 'number'
        !value.is_a(Numeric)
        # !(value.to_s =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/)
      end
    end  
  end
end