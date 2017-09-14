require 'httparty'
require 'json'
require './customer'

class Api
  BASE_URL = "https://backend-challenge-winter-2017.herokuapp.com/customers.json"
  attr_accessor :page, :customers, :response, :total_number_of_pages, :validations

  def initialize()
    @page = 1
    @customers = []
    @response = {}
    @total_number_of_pages = nil
    @validations = nil
  end

  def process
    while page <= total_pages()
      self.response = fetch()
      self.validations ||= self.response['validations']
      self.customers << self.response['customers']
      self.page +=1
    end
    self.customers.flatten!
    send_response()
  end

  private

  def fetch
    HTTParty.get(BASE_URL + "?page=" + page.to_s).parsed_response
  end

  def send_response
    invalid_customers = Hash.new { |h,k| h[k] = Array.new }
    self.customers.each do |c|
      customer = ::Customer.new(c, self.validations)
      invalid_customers['invalid_customers'] << customer.errors if customer.invalid?
    end
    invalid_customers.to_json
  end

  def total_pages
    self.total_number_of_pages || calculate_total_pages()
  end

  def calculate_total_pages
    if response.empty?
      1
    else
      pagination = response['pagination']
      self.total_number_of_pages = (pagination['total']/pagination['per_page'].to_f).ceil
    end
  end
end

api = Api.new()
puts api.process
