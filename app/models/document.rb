class Document
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true

  belongs_to :user, :required => true

  after :create, :make_folders

  def files
    path = File.join(self.folder, "**", "*")
    Dir[path].entries
  end

  def folder
    File.join(settings.root, "user_files", self.user.id.to_s, self.id.to_s)
  end

  private
  
  def make_folders
    system "mkdir -p '#{folder}'"
  end
end
