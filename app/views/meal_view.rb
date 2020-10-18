# View form `Meal`
class MealView
  def display_list(meals)
    meals.each do |meal|
      puts "#{meal.id} - #{meal.name} : #{meal.price} "
    end
  end

  def ask_for(word)
    puts "#{word}?"
    print '> '
    gets.chomp
  end
end
