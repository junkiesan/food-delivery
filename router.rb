class Router
  def initialize(meals_controller)
    @meals_controller = meals_controller
    @running = true
  end
end