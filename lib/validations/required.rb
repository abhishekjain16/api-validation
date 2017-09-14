module Validations
  module Required
    def self.validate(value, validator_value)
      if validator_value
        value.to_s.empty?
      else
        false
      end
    end
  end
end
