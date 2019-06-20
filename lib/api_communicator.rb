
require 'rest-client'
require 'json'
require 'pry'


  def create_jobs(ui1, ui2 = "", ui3 = "", username)
    system("clear")
    list_of_jobs = []
    url = "https://jobs.github.com/positions.json?page=1&search=#{ui1}&location=#{ui2}&full_time=#{ui3}"
    resp = RestClient.get(url)
    job_info = JSON.parse(resp)
    job_info.each do |job_data|
      company_name = job_data["company"]
      location = job_data["location"]
      description = job_data["description"]
      fte = job_data["type"]
      title = job_data["title"]
      created_at = job_data["created_at"]
      list_of_jobs << Job.find_or_create_by(title: title, company: company_name, location: location, description: description, fte: fte, created_at: created_at)
    end
        if list_of_jobs == []
          puts "Your search produced 0 results.".colorize(:red)
          job_search(username)
        else
          present_jobs(list_of_jobs, username)
        end
    spacing
  end

  def present_jobs(list_of_jobs, username)
    spacing
    list_of_jobs.each_with_index do |job_info, i|
      puts "#{i+1}. Title:#{job_info.title} ----- Company:#{job_info.company} ----- Location:#{job_info.location}".colorize(:light_blue)
      spacing
    end
      puts "Choose which job you'd like to see more information about.(A number between 1 and #{list_of_jobs.count} or type #{list_of_jobs.count + 1} to go to main menu.)".colorize(:light_blue)
      job_choice = gets.chomp.to_i
      chosen_job = list_of_jobs[job_choice - 1]
      system("clear")
      if job_choice == (list_of_jobs.count + 1)
        returning_user(username)
      else
        pretty_present(chosen_job)
        puts "Would you like to apply to this job? Please choose a number.".colorize(:light_blue)
        puts "1. Yes".colorize(:light_blue)
        puts "2. No".colorize(:light_blue)
        puts "3. Return to menu".colorize(:light_blue)
        puts "4. Exit".colorize(:light_blue)
        apply = gets.chomp
        system("clear")
        if apply.downcase == "1"
          system("clear")
          if Application.find_by(user_id: $current_user.id, job_id: chosen_job.id, title: chosen_job.title, company: chosen_job.company, location: chosen_job.location)
            puts "You have already applied for this job.".colorize(:red)
            present_jobs(list_of_jobs, username)
          else
            system("clear")
            Application.create(user_id: $current_user.id, job_id: chosen_job.id, title: chosen_job.title, company: chosen_job.company, location: chosen_job.location)
            puts "Application completed, returning you to your job search.".colorize(:light_blue)
            present_jobs(list_of_jobs, username)
          end
        elsif apply.downcase == "2"
          system("clear")
          present_jobs(list_of_jobs, username)
        elsif apply.downcase == "3"
          system("clear")
          returning_user(username)
        elsif apply.downcase == "4"
          system("clear")
          "Goodbye. See you later, alligator".colorize(:light_blue)
        else
          system("clear")
          puts "Incorrect input".colorize(:light_blue)
          present_jobs(list_of_jobs, username)
        end
      end
  end

  def pretty_present(chosen_job)
    puts "Title:#{chosen_job.title}".gsub(/\<.*?\>/, "").colorize(:light_blue)
    puts "Company: #{chosen_job.company}".gsub(/\<.*?\>/, "").colorize(:light_blue)
    puts "Location: #{chosen_job.location}".gsub(/\<.*?\>/, "").colorize(:light_blue)
    puts "Description: #{chosen_job.description}".gsub(/\<.*?\>/, "").colorize(:light_blue)
    puts "Full Time: #{chosen_job.fte}".gsub(/\<.*?\>/, "").colorize(:light_blue)
    spacing
  end
