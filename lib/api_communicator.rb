
require 'rest-client'
require 'json'
require 'pry'


  def create_jobs(ui1, ui2 = "", ui3 = "")
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
      Job.create(company: company_name, location: location, description: description, fte: fte, title: title, created_at: created_at)
      end
      # puts Job.all
  end

  # def get_jobs_from_api(ui1, ui2, ui3 )
  #   url = "https://jobs.github.com/positions.json?page=1&search=#{ui1}&location=#{ui2}&full_time=#{ui3}"
  #   resp = RestClient.get(url)
  #   job_info = JSON.parse(resp)
  # end

  
