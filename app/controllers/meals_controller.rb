class MealsController

  def initialize(mealrepository)
    @mealrepository = mealrepository
  end

  def add
    name = gets.chomp
    price =
    meal = gets.chomp
    @mealrepository.push(meal)
  end

  def list
    Meal.all
  end
end