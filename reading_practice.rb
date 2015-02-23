require "pg"

def db_connection
  begin
    connection = PG.connect(dbname: "todo")
    yield(connection) # allows this method to accept a block of code (in the form of a do..end or {..} block) that can be run in the middle of the method
  ensure # the ensure..end block closes out the connection. ensure guarantees the code will run: even if an exception is thrown or something goes wrong, ensure will guarantee the code for closing the connection will run
    connection.close
  end
end

# If we wanted to use this method to query for a list of tasks, we might write:

db_connection do |conn|
  conn.exec("SELECT name FROM tasks") # the do..end block accepts a single parameter: conn is assigned to the value passed into yield(connection). Within this block we use the connection to query the database (by calling the exec method)
end

# SANITIZE the input to protect against attacks using escape characters:

db_connection do |conn|
  conn.exec_params("INSERT INTO tasks (name) VALUES ($1)", params["task_name"]])
end
