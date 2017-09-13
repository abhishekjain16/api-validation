require './validations'

class Customer
  include ::Validations
  attr_accessor :errors, :validations, :attributes

  def initialize(attributes, validations)
    @validations = validations
    @attributes = attributes
    @errors = {'invalid_fields' => [], 'id' => attributes['id']}
  end

  def invalid?
    self.validations.each do |field, validators|
      if validate(field, self.attributes[field], validators)
        self.errors['invalid_fields'] << field
      end
    end
    self.errors['invalid_fields'].any?
  end
end