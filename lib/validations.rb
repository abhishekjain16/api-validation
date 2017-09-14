Dir["./validations/*.rb"].each {|file| require file }

module Validations
  def validate(field, value, validators)
    error_present = false
    validators.each do |validator, validator_value|
      break if error_present
      error_present = case validator
      when 'required'
        Required.validate(value, validator_value)
      when 'type'
        Type.validate(value, validator_value) if value
      when 'length'
        Length.validate(value, validator_value)
      end
    end
    error_present
  end
end
