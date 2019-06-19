
require 'rest-client'
require 'json'
require 'pry'


  def create_jobs(ui1, ui2 = "", ui3 = "")
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
      present_jobs(list_of_jobs)
  end

  def present_jobs(list_of_jobs)
    list_of_jobs.each_with_index do |job_info, i|
      puts "#{i+1}. Title:#{job_info.title} ----- Company:#{job_info.company} ----- Location:#{job_info.location}"
    end
      puts "Choose which job you'd like to see more information about.(A number between 1 and #{list_of_jobs.count})"
      job_choice = gets.chomp

      list_of_jobs[job_choice.to_i - 1]
        puts "Would you like to apply to this job? Yes, no, or exit"
         apply = gets.chomp
          if apply.downcase == "yes"
            Application.create(user_id: $current_user.id, job_id: list_of_jobs[job_choice.to_i - 1].id)
            #back to job list, can start a new job application
          elsif apply.downcase == "no"
            present_jobs(list_of_jobs)
          elsif apply.downcase == "exit"
            "goodbye."
          else
            puts "incorrect input"
            present_jobs(list_of_jobs)
          end
  end
