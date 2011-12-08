get "/users/new" do
  erb :new_user
end

post "/users/new" do
  user = User.create(email: params[:email], password: params[:password], name: params[:name])
  if user.saved?
    #TODO flash some success message
    redirect to "/"
  else
    #TODO flash some errors
    redirect back
  end
end

get "/users/sign_in" do
  erb :sign_in
end

post "/users/sign_in" do
  user = authenticate
  if user
    #TODO flash something
    redirect to "/"
  else
    #TODO flash some errors
    redirect back
  end
end

post "/users/sign_out" do
  log_out
  #TODO Flash something
  redirect to "/"
end


