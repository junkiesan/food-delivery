require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/session_view'
require_relative '../views/order_view'
# 'Order' Controller
class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository     = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository    = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @session_view = SessionView.new
    @order_view = OrderView.new
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @order_view.display_list(undelivered_orders)
  end

  def list_my_orders(current_user)
    list_my_undelivered_orders(current_user)
  end

  def mark_as_delivered(current_user)
    list_my_undelivered_orders(current_user)
    index = @order_view.ask_user_for_index
    my_orders = @order_repository.my_undelivered_orders(current_user)
    order = my_orders[index]
    @order_repository.mark_as_delivered(order)
  end

  private

  def select_meal
    meals = @meal_repository.all
    @meal_view.display_list(meals)
    index = @order_view.ask_user_for_index
    meals[index]
  end

  def select_employee
    employees = @employee_repository.all_delivery_guys
    @session_view.display_list(employees)
    index = @order_view.ask_user_for_index
    employees[index]
  end

  def select_customer
    customers = @customer_repository.all
    @customer_view.display_list(customers)
    index = @order_view.ask_user_for_index
    customers[index]
  end

  def list_my_undelivered_orders(user)
    orders = @order_repository.my_undelivered_orders(user)
    @order_view.display_list(orders)
  end
end
