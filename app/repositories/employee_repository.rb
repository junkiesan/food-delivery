require "csv"
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @employees = []
    load_csv if File.exist?(csv_filepath)
  end

  def all_delivery_guys
    @employees.select { |employee| employee.delivery_guy? }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_filepath, csv_options) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end