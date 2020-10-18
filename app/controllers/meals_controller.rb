require_relative "../models/meal.rb"
# Require view 

class MealsController
  attr_accessor :mealrepository
  def initialize(mealrepository)
    @mealrepository = mealrepository
  end

  def add
    name = gets.chomp
    price = gets.chomp.to_i
    meal = Meal.new(name: name, price: price)
    @mealrepository.add(meal)
  end

  def list
    Meal.all
  end
end