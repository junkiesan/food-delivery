class Order
  attr_accessor :id,
                :employee
  attr_reader :delivered,
              :meal,
              :customer
  def initialize(attributes = {})
    @id = attributes[:id]
    @employee = attributes[:employee]
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end