helpers do

  def authenticate
    @user = User.first(email: params[:email].strip)
    return false unless @user
    if @user.password == params[:password].strip
      session[:user] = @user.id
      return @user
    else
      return false
    end
  end

  def current_user
    User.get(session[:user]) || false
  end

  def logged_in?
    !!current_user
  end

  def log_out
    session[:user] = nil
  end

end
