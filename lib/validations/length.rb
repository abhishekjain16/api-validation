module Validations
  module Length
    def self.validate(value, validator_object)
      error_present = false
      validator_object.each do |type, validator_value|
        break if error_present
        if type == "min"
          error_present = value.length < validator_value
        elsif type == "max"
          error_present = value.length > validator_value
        end
      end
      error_present
    end
  end
end
