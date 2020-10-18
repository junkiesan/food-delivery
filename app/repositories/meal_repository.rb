# 'Meal' Repository
class MealRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @meals        = []
    @next_id      = 1
    @csv_options  = { headers: :first_row, header_converters: :symbol }
    load_csv
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_to_csv
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def load_csv
    if File.exist?(@csv_filepath)
      CSV.foreach(@csv_filepath, @csv_options) do |row|
        row[:id]    = row[:id].to_i
        row[:price] = row[:price].to_i
        @meals << Meal.new(row)
      end
      @next_id = @meals.last.id + 1 unless @meals.empty?
    else puts "Sorry mate, file doesn't exist!"
    end
  end

  def save_to_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << %i[id name price]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end