# `Router` to link them all
class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        @current_user.manager? ? route_manager_action : route_delivery_guy_action
      end
      print `clear`
    end
  end

  private

  def route_manager_action
    print_manager_menu
    choice = gets.chomp.to_i
    print `clear`
    manager_action(choice)
  end

  def route_delivery_guy_action
    print_delivery_guy_menu
    choice = gets.chomp.to_i
    print `clear`
    delivery_guy_action(choice)
  end

  def print_manager_menu
    puts '--------------------'
    puts '------- MENU -------'
    puts '--------------------'
    puts '1. Add new meal'
    puts '2. List all meals'
    puts '3. Add new customer'
    puts '4. List all customers'
    puts '7. Logout Bitch'
    puts '8. Exit'
    print '> '
  end

  def print_delivery_guy_menu
    puts '--------------------'
    puts '------- MENU -------'
    puts '--------------------'
    puts '1. Add new meal'
    puts '2. List all meals'
    puts '3. Logout Bitch'
    puts '4. Exit'
    print '> '
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 7 then logout!
    when 8 then stop!
    else puts 'Try again looser !'
    end
  end

  def delivery_guy_action(choice)
    case choice
    when 1 then stop!
    when 2 then stop!
    when 3 then logout!
    when 4 then stop!
    else puts 'Try again looser !'
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
