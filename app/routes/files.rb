get "/documents/:id/files" do
  #TODO implement
end

get "/documents/:id/files/new" do
  raise "Nicht berechtigt" if not logged_in?
  erb :new_file
end
