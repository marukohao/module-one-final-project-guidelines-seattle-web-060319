#here we will put all of our messages for user input
class CliInterface


  def welcome
    spacing
    puts "  _____ _ _   _    _       _            _       _"
    puts " / ____(_) | | |  | |     | |          | |     | |"
    puts "| |  __ _| |_| |__| |_   _| |__        | | ___ | |__  ___".colorize(:light_blue)
    puts "| | |_ | | __|  __  | | | | '_ \\   _   | |/ _ \\| '_ \\/ __|".colorize(:light_blue)
    puts "| |__| | | |_| |  | | |_| | |_) | | |__| | (_) | |_) \\__ \\".colorize(:blue)
    puts " \\_____|_|\\__|_|  |_|\\__,_|_.__/   \\____/ \\___/|_.__/|___/".colorize(:blue)
    spacing
    puts "Hello! Welcome to Github Jobs!"
  end

  def user_login
    puts "Are you a new user or existing user? Please input a number.".colorize(:light_blue)
    puts "1. New User".colorize(:light_blue)
    puts "2. Existing User".colorize(:light_blue)
    user_login_answer = gets.chomp
      system("clear")
      if user_login_answer == "1"
        user_create
      elsif user_login_answer == "2"
        existing_user_login
      else
        puts "Please enter 1 or 2"
        user_login
      end
    spacing
  end

  def existing_user_login
    system("clear")
    puts "What is your full name?".colorize(:light_blue)
    username = gets.chomp
    puts "Please enter your birthday (mm/dd/yyyy)".colorize(:light_blue)
    user_birthday = gets.chomp
    if User.find_by(name: username, birthday: user_birthday)
      $current_user = User.find_by(name: username, birthday: user_birthday)
      returning_user(username)
    else
      system("clear")
      puts "Your account does not exist, please make your choice:".colorize(:light_blue)
      puts "1.Create new account".colorize(:light_blue)
      puts "2.Go to login menu".colorize(:light_blue)
      wrong_login = gets.chomp
      system("clear")
      if wrong_login == "1"
        user_create
      elsif wrong_login == "2"
        user_login
      else
        puts "Invalid input. Returning you to login menu.".colorize(:red)
        user_login
      end
    end
    spacing
  end

  def returning_user(username)
    system("clear")
    puts "Welcome, #{username}! What would you like to do? Please input a number.".colorize(:light_blue)
    puts "1. Search for a job".colorize(:light_blue)
    puts "2. See what jobs I have applied for.".colorize(:light_blue)
    puts "3. Udpate my information.".colorize(:light_blue)
    puts "4. Delete an application.".colorize(:light_blue)
    puts "5. Exit.".colorize(:light_blue)
      returning_user_selection = gets.chomp
        if returning_user_selection == "1"
          job_search(username)
        elsif returning_user_selection == "2"
          display_applications(username)
        elsif returning_user_selection == "3"
          update_find_by_name(username)
        elsif returning_user_selection == "4"
          destroy_application(username)
        elsif returning_user_selection == "5"
          system("clear")
          see_ya_later
        else
          puts "You've made the wrong selection, please start again.".colorize(:red)
          returning_user(username)
        end
    spacing
  end

  def display_applications(username)
    system("clear")
    if $current_user.applications == []
      puts "You haven't applied for any jobs.".colorize(:red)
      job_search(username)
    else
      puts "Here are the jobs you have applied for:".colorize(:light_blue)
      spacing
      $current_user.applications.each_with_index do |job_info, i|
        current_job_app = Job.find_by(id: job_info.job_id)
        puts "#{i+1}. Title:#{current_job_app.title} ----- Company:#{current_job_app.company} ----- Location:#{current_job_app.location}".colorize(:light_blue)
        spacing
      end
      puts "What would you like to do now? Please choose a number:".colorize(:light_blue)
      puts "1. Go back to main menu.".colorize(:light_blue)
      puts "2. See how many people also applied for the same jobs.".colorize(:light_blue)
      puts "3. See job that has the most applications.".colorize(:light_blue)
      puts "4. Exit.".colorize(:light_blue)
      choice = gets.chomp
      system("clear")
      if choice == "1"
        returning_user(username)
      elsif choice == "2"
        count_applicants(username)
      elsif choice == "3"
        most_applications(username)
      elsif choice == "4"
        system("clear")
        see_ya_later
      else
        puts "Invalid choice, returning you to the main menu.".colorize(:red)
        returning_user(username)
      end
    end
    spacing
  end

  def most_applications(username)
    system("clear")
    puts "Job with the most applications:".colorize(:light_blue)
    spacing
    pop_job = Application.group(:title, :company, :location).order('COUNT(user_id) DESC').limit(1)
    # binding.pry
    most_job_info = Job.find_by(title: pop_job[0].title, location: pop_job[0].location, company: pop_job[0].company)
      puts "#{Application.where(title: pop_job[0].title, location: pop_job[0].location, company: pop_job[0].company).count}".colorize(:red) + " person(s) applied for this job. ----- Title:#{most_job_info.title} ----- Company:#{most_job_info.company} ----- Location:#{most_job_info.location}".colorize(:light_blue)
      spacing
      puts "What would you like to do now? Please choose a number:".colorize(:light_blue)
      puts "1. Go back to main menu.".colorize(:light_blue)
      puts "2. Exit.".colorize(:light_blue)
      choice = gets.chomp
      system("clear")
      if choice == "1"
        returning_user(username)
      elsif choice == "2"
        see_ya_later
      else
        puts "Invalid choice, returning you to the main menu.".colorize(:red)
        returning_user(username)
      end
      spacing
  end

  def count_applicants(username)
    puts "Amount of people who applied to the same jobs:".colorize(:light_blue)
    spacing
    $current_user.applications.each_with_index do |job_app, i|
      job = Job.find_by(id: job_app.job_id)
      puts "#{i+1}. Number of person(s) applied: #{Application.where(title: job_app.title, location: job_app.location, company: job_app.company).count} Title:#{job.title} ----- Company:#{job.company} ----- Location:#{job.location}".colorize(:light_blue)
    end
    puts "What would you like to do now? Please choose a number:".colorize(:light_blue)
      puts "1. Go back to main menu.".colorize(:light_blue)
      puts "2. Exit.".colorize(:light_blue)
      choice = gets.chomp
      if choice == "1"
        returning_user(username)
      elsif choice == "2"
        see_ya_later
      else
        puts "Invalid choice, returning you to the main menu.".colorize(:red)
        returning_user(username)
      end
      spacing
  end

  def destroy_application(username)
    system("clear")
    puts "Current Applications:".colorize(:light_blue)
    spacing
    $current_user.applications.each_with_index do |job_info, i|
      current_job_app = Job.find_by(id: job_info.job_id)
      puts "#{i+1}. Title:#{current_job_app.title} ----- Company:#{current_job_app.company} ----- Location:#{current_job_app.location}".colorize(:light_blue)
      spacing
    end
    puts "Choose which application you'd like to delete.(A number between 1 and #{$current_user.applications.count})".colorize(:light_blue)
      job_choice = gets.chomp
      $current_user.applications.destroy($current_user.applications[job_choice.to_i - 1].id)
    system("clear")
    puts "Your application has been destroyed, what would you like to do now? Please choose a number:".colorize(:light_blue)
    puts "1. Go back to main menu.".colorize(:light_blue)
    puts "2. See your list of applications.".colorize(:light_blue)
    puts "3. Exit.".colorize(:light_blue)
      choice = gets.chomp
      if choice == "1"
        returning_user(username)
      elsif choice == "2"
        display_applications(username)
      elsif choice == "3"
        see_ya_later
      else
        puts "Invalid choice, returning you to the main menu.".colorize(:red)
        returning_user(username)
      end
    spacing
  end

  def job_search(username)
    puts "Welcome to your job search. What are some keywords you are looking for in a job. It could be job title, languages you use or keywords such as 'diversity'.".colorize(:light_blue)
    ui1 = gets.chomp
    puts "Great, please enter a location by city, then state. e.g 'Seattle, WA'".colorize(:light_blue)
    ui2 = gets.chomp
    puts "Do you only want full-time jobs? Please choose a number.".colorize(:light_blue)
    puts "1. Yes.".colorize(:light_blue)
    puts "2. No.".colorize(:light_blue)
    ui3 = gets.chomp
      if ui3 == "1"
        ui3 = "on"
      else
        ui3 = ""
      end
    create_jobs(ui1, ui2, ui3, username)
    spacing
  end

  def update_find_by_name(username)
    system("clear")
    puts "What would you like to change your name to.".colorize(:light_blue)
      new_name = gets.chomp
    user = User.find_by(name: username)
    user.update(name: new_name)
    username = new_name
    system("clear")
    puts "Hi #{new_name}, you've successfully updated your information!".colorize(:light_blue)
    puts "What would you like to do now? Please choose a number:".colorize(:light_blue)
    puts "1. Go back to main menu.".colorize(:light_blue)
    puts "2. See your list of applications.".colorize(:light_blue)
    puts "3. Exit.".colorize(:light_blue)
    choice = gets.chomp
    if choice == "1"
      returning_user(username)
    elsif choice == "2"
      display_applications(username)
    elsif choice == "3"
      see_ya_later
    else
      puts "Invalid choice, returning you to the main menu.".colorize(:red)
      returning_user(username)
    end
    spacing
  end

  def user_create
    puts "Please enter your full name".colorize(:light_blue)
    username = gets.chomp
    puts "Please enter your birthday (mm/dd/yyyy)".colorize(:light_blue)
    user_birthday =gets.chomp
    if User.find_by(name: username, birthday: user_birthday)
      puts "You already have an account, you will be signed now.".colorize(:red)
      spacing
      $current_user = User.find_by(name: username, birthday: user_birthday)
      returning_user(username)
    else
      $current_user = User.create(name: username, birthday: user_birthday)
      puts "Your account has been created.".colorize(:red)
      spacing
      returning_user(username)
    end
    spacing
  end

  def spacing
    puts "---------------------------------------------------------------------------------------------------"
  end

  def see_ya_later
puts "See ya later, ".colorize(:light_blue)
puts "           _  _".colorize(:green)
puts " _ _      (0)(0)-._  _.-'^^'^^'^^'^^'^^'--.".colorize(:green)
puts "(.(.)----'`        ^^'                /^   ^^-._".colorize(:green)
puts "(    `                 \\             |    _    ^^-._".colorize(:green)
puts "VvvvvvvVv~~`__,/.._>  /:/:/:/:/:/:/:/\\  (_..,______^^-.".colorize(:green)
puts "     `^^^^^^^^`/  /   /  /`^^^^^^^^^>^^>^`>  >        _`)  )".colorize(:green)
puts "             (((`   (((`          (((`  (((`        `'--'^".colorize(:green)

  end

end
