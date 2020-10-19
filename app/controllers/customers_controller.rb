class CustomerController
  def initialize(customer_repository)
    @customer_repository = customer_repository
  end

  def add
    
  end

  def list
    display_customers
  end

  private

  def display_customers
    @customer_repository.all
  end
end