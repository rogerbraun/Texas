class User
  include BCrypt
  include DataMapper::Resource
  
  property :id, Serial
  property :email, String
  property :password_hash, String, :accessor => :private, :length => 60
  property :address , String
  property :name, String

  has n, :documents

  validates_uniqueness_of :email
  validates_presence_of :email, :name, :password_hash

  after :create, :make_folders
  
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def folder
    File.join(settings.root, "user_files", self.id.to_s)
  end

  private

  def make_folders
    system "mkdir -p '#{folder}'"
  end
end
