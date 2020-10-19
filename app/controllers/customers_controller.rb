require_relative '../views/customer_view.rb'
require_relative '../models/customer.rb'
# `Customer` Controller
class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customer_view = CustomerView.new
  end

  def add
    name = @customer_view.ask_for('name')
    address = @customer_view.ask_for('address')
    customer = Customer.new(name: name, address: address)
    @customer_repository.create(customer)
    display_customers
  end

  def list
    display_customers
  end

  private

  def display_customers
    customers = @customer_repository.all
    @customer_view.display_list(customers)
  end
end
