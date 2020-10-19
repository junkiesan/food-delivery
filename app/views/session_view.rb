# `Session` view
class SessionView
  def ask_for(word)
    puts "#{word} "
    print '> '
    return gets.chomp
  end

  def print_wrong_credentials
    puts 'Wrong credentials... Try again'
  end

  def display_list(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end
end
