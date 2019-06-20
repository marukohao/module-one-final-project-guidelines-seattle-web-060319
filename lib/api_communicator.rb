
require 'rest-client'
require 'json'
require 'pry'


  def create_jobs(ui1, ui2 = "", ui3 = "", username)
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
      list_of_jobs << Job.create(title: title, company: company_name, location: location, description: description, fte: fte, created_at: created_at)
      end
      # binding.pry
      if list_of_jobs == []
        puts "Your search produced 0 results."
        job_search(username)
      else
        present_jobs(list_of_jobs, username)
      end
  end

  def present_jobs(list_of_jobs, username)
    list_of_jobs.each_with_index do |job_info, i|
      puts "#{i+1}. Title:#{job_info.title} ----- Company:#{job_info.company} ----- Location:#{job_info.location}"
    end
      puts "Choose which job you'd like to see more information about.(A number between 1 and #{list_of_jobs.count} or type #{list_of_jobs.count + 1} to leave this page.)"
      job_choice = gets.chomp.to_i
      if job_choice == (list_of_jobs.count + 1)
        returning_user(username)
      else
        chosen_job = list_of_jobs[job_choice.to_i - 1]
        pretty_present(chosen_job)
        puts "Would you like to apply to this job? Please choose a number."
        puts "1. Yes"
        puts "2. No"
        puts "3. Return to menu"
        puts "4. Exit"
        apply = gets.chomp
        if apply.downcase == "1"
          Application.create(user_id: $current_user.id, job_id: chosen_job.id)
          puts "Application completed, returning you to your job search."
          present_jobs(list_of_jobs, username)
        elsif apply.downcase == "2"
          present_jobs(list_of_jobs, username)
        elsif apply.downcase == "3"
          returning_user(username)
        elsif apply.downcase == "4"
          "Goodbye."
        else
          puts "incorrect input"
          present_jobs(list_of_jobs, username)
        end
      end
  end

  def pretty_present(chosen_job)
    puts "Title:#{chosen_job.title}".gsub(/\<.*?\>/, "")
    puts "Company: #{chosen_job.company}".gsub(/\<.*?\>/, "")
    puts "Location: #{chosen_job.location}".gsub(/\<.*?\>/, "")
    puts "Description: #{chosen_job.description}".gsub(/\<.*?\>/, "")
    puts "Full Time: #{chosen_job.fte}".gsub(/\<.*?\>/, "")
  end
