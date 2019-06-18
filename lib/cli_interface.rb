#here we will put all of our messages for user input
def welcome
  puts "Hello! Welcome to Github Jobs!"
end

def user_login
  puts "Are you a new user or existing user? Please input a number."
  puts "1. New User"
  puts "2. Existing User"
end

def returning_user
  puts "Welcome back, #{user_nameTBD}! What would you like to do? Please input a number."
  puts "1. Search for a job"
  puts "2. See what jobs I have applied for."
  puts "3. Udpate my information."
  puts "4. Delete an application."
  puts "5. Exit."
end

def job_search_descrption(returning_user_response)
  #user will search for job here
  puts "Great. What are some keywords you are looking for in a job. It could job title, or languages you use."
end

def job_search_location
  puts "Great, please enter a location by city, then state. e.g 'Seattle, WA'"
end

def job_search_FTE
  puts "Do you only want full-time jobs? Please choose a number."
  puts "1. Yes."
  puts "2. No."
end

def update
  puts "Where do you live now?"
  # puts "Do you want to add more languages to your profile?"
end

def delete
  puts "Please choose which application you would like to delete."
end

def user_create
  puts "Please enter your full name"
  username = gets.chomp
  puts "Please enter your birthday (mm/dd/yyyy)"
  user_birthday =gets.chomp
  User.create(name: username, birthday: user_birthday)
end

def existing_user_info
