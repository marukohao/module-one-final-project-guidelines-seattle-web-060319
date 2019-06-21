* Describe something you struggled to build, and show us how you ultimately implemented it in your code. 
* The biggest struggle for us, is for destroying a record, we used activerecord destroy method to delete the application for our user, but after we did this, this application record was still showing in the application list of this user, but when we exited our program and reran  it, this record disappeared. After several tries, we still got the same bug. Instead of appending the destroy method after the string because we were finding and THEN destroying, we destroyed by finder which was instantaneous. 
* 
* Eg: $current_user.applications.destroy(Application.where(user_id: $current_user.id)[job_choice.to_i - 1].id) 
* 
* Application.find($current_user.applications[job_choice.to_i - 1].id).destroy
* 
* We get the application record destroyed directly from current_user.application  instead of from application, and it works, our guess is, when we destroyed the application record from application database, it can’t recognized the association with the application under current_user, so it won’t delete the application record under the current user, just delete the record under application. But when we rerun our program, when user restore the data for their applications, the data has been destroyed and can’t create a new application, that’s why it can’t be shown when we rerun our program.


3 things learned from our program:
1. Global variable
2. Api
3. Colorize, system(“clear”)
4. How to deal with git merge conflict
5. gsub(/\<.*?\>/)


Address, if anything, what you would change or add to what you have today?
Job id issue


Highlight code:
gsub(/\<.*?\>/