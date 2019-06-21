#### Discussion Questions


Describe something you struggled to build, and show us how you ultimately implemented it in your code.
  * The biggest struggle for us, was learning where to append the destroy method in our code.

```ruby
$current_user.applications.destroy(Application.where(user_id: $current_user.id)[job_choice.to_i - 1].id)
```
VS
```ruby
Application.find($current_user.applications[job_choice.to_i - 1].id).destroy
```
Still not sure what the problem is, but we think.....


##### Things learned from our program:
1. Global variable
2. Api
3. Colorize, system(“clear”)
4. How to deal with git merge conflict
5. .gsub(/\<.*?\>/)

###### Address, if anything, what you would change or add to what you have today?

  * Job id issue


##### Highlight code:
```ruby
def pretty_present(chosen_job)
  puts "Title:#{chosen_job.title}".gsub(/\<.*?\>/, "").colorize(:light_blue)
  puts "Company: #{chosen_job.company}".gsub(/\<.*?\>/, "").colorize(:light_blue)
  puts "Location: #{chosen_job.location}".gsub(/\<.*?\>/, "").colorize(:light_blue)
  puts "Description: #{chosen_job.description}".gsub(/\<.*?\>/, "").colorize(:light_blue)
  puts "Full Time: #{chosen_job.fte}".gsub(/\<.*?\>/, "").colorize(:light_blue)
  spacing
end
```
```ruby
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
  ```
