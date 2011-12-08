get "/documents" do
  raise "Nicht berechtigt" if not logged_in?
  @documents = current_user.documents
  erb :index_documents
end

get "/documents/:id" do
  @document = Document.get(params[:id])
  raise "Nicht berechtigt" if @document.user != current_user
  erb :show_document
end

get "/documents/new" do
  raise "Nicht berechtigt" if not logged_in?
  erb :new_document
end

post "/documents/new" do
  raise "Nicht berechtigt" if not logged_in?
  @document = current_user.documents.create(title: params[:title])
  redirect to "/documents/#{document.id}"
end
