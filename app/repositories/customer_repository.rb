require 'csv'
require_relative "../models/customer"

# `Customer` repository
class CustomerRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @customers    = []
    @next_id      = 1
    load_csv if File.exist?(@csv_filepath)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_to_csv
  end

  def find(id)
    @customers.find { |customer| customer.id == id}
  end

  private

  def save_to_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << %w[id name address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_filepath, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:address] = row[:address]
      @customers << Customer.new(row)
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end
end