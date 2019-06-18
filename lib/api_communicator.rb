

  url = "https://jobs.github.com/positions.json?page=1&search=#{ui1}&location=#{ui2}&full_time=#{ui3}"
  resp = RestClient.get(url)
  job_info = JSON.parse(resp)

  def create_jobs
    job_info.each do |job_data|
      company_name = job_data["company"]
      location = job_data["location"]
      description = job_data["description"]
      type = job_data["type"]
      title = job_data["title"]
      created_at = job_data["created_at"]
      Job.create(company: company_name, location: location, description: description, type: type, title: title, created_at: created_at)
    end
  end
