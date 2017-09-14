require './validations'

class Customer
  include ::Validations
  attr_accessor :errors, :validations, :attributes

  def initialize(attributes, validations)
    @validations = validations
    @attributes = attributes
    @errors = {'id' => attributes['id'], 'invalid_fields' => []}
  end

  def invalid?
    self.validations.each do |validation|
      validation.each do |field, validators|
        if validate(field, self.attributes[field], validators)
          self.errors['invalid_fields'] << field
        end
      end
    end
    self.errors['invalid_fields'].any?
  end
end
