require_relative '../models/meal.rb'
require_relative '../views/meal_view.rb'
# `Meal` controller
class MealsController
  attr_accessor :meal_repository
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meal_view = MealView.new
  end

  def add
    name = @meal_view.ask_for('name')
    price = @meal_view.ask_for('price').to_i
    meal = Meal.new(name: name, price: price)
    @meal_repository.create(meal)
  end

  def list
    display_meals
  end

  private

  def display_meals
    list = @meal_repository.all
    @meal_view.display_list(list)
  end
end