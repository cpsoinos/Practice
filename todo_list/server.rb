require "sinatra"

# get "/hello" do
#   "<p>Hello, world! The current time is #{Time.now}.</p>"
# end

get "/tasks" do
  tasks = File.readlines("tasks.txt")
  erb :index, locals: { tasks: tasks }
end

get "/tasks/:task_name" do
  erb :show, locals: { task_name: params[:task_name] }
end

post "/tasks" do
  task = params["task_name"]
  File.open("tasks.txt", "a") do |file|
    file.puts(task)
  end
  redirect "/tasks"
end


# set :views, File.join(File.dirname(__FILE__), "views")
# set :public_folder, File.join(File.dirname(__FILE__), "public")



#   html = '''
#   <!DOCTYPE html>
#   <html>
#     <head>
#       <title>Basic HTML Page</title>
#       <link rel="stylesheet" href="home.css">
#     </head>
#
#     <body>
#       <h1>TODO list</h1>
#       <ul>
#   '''
#
#   tasks.each do |task|
#     html += "<li>#{task}</li>"
#   end
#
#   html += '''
#       </ul>
#     </body>
#   </html>
#   '''
# end
