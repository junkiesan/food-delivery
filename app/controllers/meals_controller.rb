class MealsController

  def initialize(mealrepository)
    @mealrepository = mealrepository
  end

  def add
    name = gets.chomp
    price =
    meal = gets.chomp
    @mealrepository.add(meal)
  end

  def list
    Meal.all
  end
end