# View form `Customer`
class CustomerView
  def display_list(customers)
    customers.each do |customer|
      puts "#{customer.id} - #{customer.name} : #{customer.address} "
    end
  end

  def ask_for(word)
    puts "#{word}?"
    print '> '
    gets.chomp
  end
end
