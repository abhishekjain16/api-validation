module Validations
  module Length
    def self.validate(value, validator_object)
      validator_value.each do |type, validator_value|
        if type == "min"
          value.length < validator_value
        elsif type == "max"
          value.length > validator_value
        end
      end
    end
  end
end