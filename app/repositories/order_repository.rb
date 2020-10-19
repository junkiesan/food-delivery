require 'csv'
require_relative '../models/order'
# `Order` Repository
class OrderRepository
  def initialize(csv_filepath, meal_repository, customer_repository, employee_repository)
    @csv_filepath = csv_filepath
    @orders = []
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @next_id = 1
    load_csv if File.exist?(@csv_filepath)
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_to_csv
  end

  def undelivered_orders
    @orders.reject(&:delivered?)
  end

  def mark_as_delivered(order)
    order.deliver!
    save_to_csv
  end

  def my_undelivered_orders(employee)
    @orders.select { |order| order.employee == employee && !order.delivered? }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_filepath, csv_options) do |row|
      row[:id]        = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'
      row[:meal]      = @meal_repository.find(row[:meal_id].to_i)
      row[:employee]  = @employee_repository.find(row[:employee_id].to_i)
      row[:customer]  = @customer_repository.find(row[:customer_id].to_i)
      @orders << Order.new(row)
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_to_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << %w[id delivered meal_id employee_id customer_id]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end
end
