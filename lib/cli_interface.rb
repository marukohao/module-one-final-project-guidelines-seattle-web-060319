#here we will put all of our messages for user input
class CliInterface


def welcome
  puts "Hello! Welcome to Github Jobs!"
end

def user_login
  puts "Are you a new user or existing user? Please input a number.".colorize(:color => :light_blue, :background => :red)
  puts "1. New User"
  puts "2. Existing User"
  user_login_answer = gets.chomp
    if user_login_answer == "1"
      user_create
    elsif user_login_answer == "2"
      puts "What is your full name?"
      username = gets.chomp
      returning_user(username)
      # if User.find_by(name: username) exist
      #   $current_user = User.find_by(name: username)
      # else 
      #   puts "your account is not exist, please create a new account"
      #   user_create
      # end
    else
      puts "Please enter 1 or 2"
      user_login
    end
end

def returning_user(username)
  puts "Welcome back, #{username}! What would you like to do? Please input a number."
  puts "1. Search for a job"
  puts "2. See what jobs I have applied for."
  puts "3. Udpate my information."
  puts "4. Delete an application."
  puts "5. Exit."
    returning_user_selection = gets.chomp
      if returning_user_selection == "1"
        job_search
        #back to main page
      elsif returning_user_selection == "2"
        puts $current_user.applications
        #back to main page
      elsif returning_user_selection == "3"
        update_find_by_name(username)
                #back to main page
      elsif returning_user_selection == "4"
        puts "wait"
                #back to main page
      elsif returning_user_selection == "5"
        puts "See ya later, alligator!"
      else
        puts "You've made the wrong selection, please start again."
        returning_user(username)
      end
end

def job_search
  #user will search for job here
  puts "Great. What are some keywords you are looking for in a job. It could be job title, or languages you use."
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
  create_jobs(ui1, ui2, ui3)
end

def update_find_by_name(username)
  puts "What would you like to change your name to."
    new_name = gets.chomp
user = User.find_by(name: username)
user.update(name: new_name)
  puts "Hi #{new_name}, you've successfully updated your information!"
end

def delete
  puts "Please choose which application you would like to delete."
end

def user_create
  puts "Please enter your full name"
  username = gets.chomp
  # if User.find_by(name: username) exist
  #   puts "you have already had an accout, you will be signed in as a returning user"
  #   returning_user(username)
  # else
    puts "Please enter your birthday (mm/dd/yyyy)"
    user_birthday =gets.chomp
    $current_user = User.create(name: username, birthday: user_birthday)
    returning_user(username)
  # end
end

end
