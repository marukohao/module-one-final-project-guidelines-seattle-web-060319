#here we will put all of our messages for user input
class CliInterface


  def welcome
    puts "Hello! Welcome to Github Jobs!"
  end

  def user_login
    puts "Are you a new user or existing user? Please input a number."#.colorize(:color => :light_blue, :background => :red)
    puts "1. New User"
    puts "2. Existing User"
    user_login_answer = gets.chomp
      if user_login_answer == "1"
        user_create
      elsif user_login_answer == "2"
        puts "What is your full name?"
        username = gets.chomp
        puts "Please enter your birthday (mm/dd/yyyy)"
        user_birthday = gets.chomp
        if User.find_by(name: username, birthday: user_birthday)
          $current_user = User.find_by(name: username, birthday: user_birthday)
          returning_user(username)
        else
          puts "Your account does not exist, please create a new account now:"
          user_create
        end
      else
        puts "Please enter 1 or 2"
        user_login
      end
  end

  def returning_user(username)
    puts "Welcome, #{username}! What would you like to do? Please input a number."
    puts "1. Search for a job"
    puts "2. See what jobs I have applied for."
    puts "3. Udpate my information."
    puts "4. Delete an application."
    puts "5. Exit."
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
          puts "See ya later, alligator!"
        else
          puts "You've made the wrong selection, please start again."
          returning_user(username)
        end
  end

  def display_applications(username)
    if $current_user.applications == []
      puts "You haven't applied for any jobs."
      job_search(username)
    else
      $current_user.applications.each_with_index do |job_info, i|
        current_job_app = Job.find_by(id: job_info.job_id)
        puts "#{i+1}. Title:#{current_job_app.title} ----- Company:#{current_job_app.company} ----- Location:#{current_job_app.location}"
      end
      puts "What would you like to do now? Please choose a number:"
      puts "1. Go back to main menu."
      puts "2. See how many people also applied for the same jobs."
      puts "3. See job that has the most applications."
      puts "4. Exit."
      choice = gets.chomp
        if choice == "1"
          returning_user(username)
        elsif choice == "2"
          count_applicants(username)
        elsif choice == "3"
          most_applications(username)
        elsif choice == "4"
          puts "See you later!"
        else
          puts "Invalid choice, returning you to the main menu."
          returning_user(username)
        end
    end
  end

  def most_applications(username)
    pop_job = Application.group(:job_id).order('COUNT(user_id) DESC').limit(1)
    # binding.pry
    most_job_info = Job.find_by(id: pop_job[0].job_id )
      puts "#{Application.where(job_id:pop_job[0].job_id).count} person(s) applied for this job. Title:#{most_job_info.title} ----- Company:#{most_job_info.company} ----- Location:#{most_job_info.location}"
      puts "What would you like to do now? Please choose a number:"
      puts "1. Go back to main menu."
      puts "2. Exit."
      choice = gets.chomp
      if choice == "1"
        returning_user(username)
      elsif choice == "2"
        puts "See you later!"
      else
        puts "Invalid choice, returning you to the main menu."
        returning_user(username)
      end
  end

  def count_applicants(username)
    $current_user.applications.each_with_index do |job_app, i|
      job = Job.find_by(id: job_app.job_id)
      puts "#{i+1}. Number of person(s) applied: #{Application.where(job_id:job_app.job_id).count} Title:#{job.title} ----- Company:#{job.company} ----- Location:#{job.location}"
    end
    puts "What would you like to do now? Please choose a number:"
      puts "1. Go back to main menu."
      puts "2. Exit."
      choice = gets.chomp
      if choice == "1"
        returning_user(username)
      elsif choice == "2"
        puts "See you later!"
      else
        puts "Invalid choice, returning you to the main menu."
        returning_user(username)
      end
      # puts "Would you like to delete any applications? Yes or no?"
      # delete_app = gets.chomp
      #   if delete_app.downcase == "yes"
      #     destroy_application(username)
      #   elsif delete_app.downcase == "no"
      #     returning_user(username)
      #   else
      #     puts "invalid input"
      #     display_applications(username)
      #   end
  end

  def destroy_application(username)
    $current_user.applications.each_with_index do |job_info, i|
      current_job_app = Job.find_by(id: job_info.job_id)
      puts "#{i+1}. Title:#{current_job_app.title} ----- Company:#{current_job_app.company} ----- Location:#{current_job_app.location}"
    end
    puts "Choose which application you'd like to delete.(A number between 1 and #{$current_user.applications.count})"
      job_choice = gets.chomp
      $current_user.applications.destroy($current_user.applications[job_choice.to_i - 1].id)
      # Application.find($current_user.applications[job_choice.to_i - 1].id).destroy
      # oldUsername = $current_user.name
      # dob = $current_user.birthday
      # $current_user = User.find_by(name: oldUsername, birthday: dob)
    puts "Your application has been destroyed, what would you like to do now? Please choose a number:"
    puts "1. Go back to main menu."
    puts "2. See your list of applications."
    puts "3. Exit."
      choice = gets.chomp
      if choice == "1"
        returning_user(username)
      elsif choice == "2"
        display_applications(username)
      elsif choice == "3"
        puts "See you later!"
      else
        puts "Invalid choice, returning you to the main menu."
        returning_user(username)
      end
  end

  def job_search(username)
    #user will search for job here
    puts "Welcome to your job search. What are some keywords you are looking for in a job. It could be job title, languages you use or keywords such as 'diversity'."
    ui1 = gets.chomp
    puts "Great, please enter a location by city, then state. e.g 'Seattle, WA'"
    ui2 = gets.chomp
    puts "Do you only want full-time jobs? Please choose a number."
    puts "1. Yes."
    puts "2. No."
    ui3 = gets.chomp
      if ui3 == "1"
        ui3 = "on"
      else
        ui3 = ""
      end
    create_jobs(ui1, ui2, ui3, username)
  end

  def update_find_by_name(username)
    puts "What would you like to change your name to."
      new_name = gets.chomp
  user = User.find_by(name: username)
  user.update(name: new_name)
  username = new_name
    puts "Hi #{new_name}, you've successfully updated your information!"
    puts "What would you like to do now? Please choose a number:"
    puts "1. Go back to main menu."
    puts "2. See your list of applications."
    puts "3. Exit."
    choice = gets.chomp
    if choice == "1"
      returning_user(username)
    elsif choice == "2"
      display_applications(username)
    elsif choice == "3"
      puts "See you later!"
    else
      puts "Invalid choice, returning you to the main menu."
      returning_user(username)
    end
  end

  def user_create
    puts "Please enter your full name"
    username = gets.chomp
    puts "Please enter your birthday (mm/dd/yyyy)"
    user_birthday =gets.chomp
    if User.find_by(name: username, birthday: user_birthday)
      puts "You already have an account, you will be signed now."
      $current_user = User.find_by(name: username, birthday: user_birthday)
      returning_user(username)
    else
      $current_user = User.create(name: username, birthday: user_birthday)
      puts "Your account has been created."
      returning_user(username)
    end
  end

end
