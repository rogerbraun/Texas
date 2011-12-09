get "/documents/:id/files" do
  #TODO implement
end

get "/documents/:id/files/new" do
  raise "Nicht berechtigt" if not logged_in?
  @document = Document.get(params["id"])
  erb :new_file
end

post "/documents/:id/files/new" do
  raise "Nicht berechtig" if not logged_in?
  @document = Document.get(params["id"])
  puts params.inspect
  filename = File.basename(params["name"].strip)
  #TODO do some error checking
  raise "File exists already" if @document.files.map{|n| File.basename(n)}.include?(filename)
  path = File.join(@document.folder, filename)
  system "touch '#{path}'"
  redirect to "/documents/#{@document.id}"
end

get "/documents/:id/files/:name" do
  raise "Nicht berechtigt" if not logged_in?
  @document = Document.get(params["id"])
  @filename = File.basename(params[:name])
  path = File.join(@document.folder, @filename)
  @content = open(path).read
  erb :edit_file
end

post "/documents/:id/files/:name" do
  raise "Nicht berechtigt" if not logged_in?
  @document = Document.get(params["id"])
  filename = File.basename(params[:name])
  path = File.join(@document.folder, filename)
  open(path, "w") do |f|
    f.write(params[:content])
  end
  redirect to "/documents/#{@document.id}" 
end
