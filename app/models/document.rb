class Document
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :required => true

  belongs_to :user, :required => true

  after :create, :make_folders

  def compile
    doc = files.map{|file| Kramdown::Document.new(File.read(file)).to_latex}.join("\n")
    temp = File.join(self.folder, "tmp")
    template_path = File.join(settings.root, "user_files", "layouts", "layout.tex")
    template = File.read(template_path)
    
    full_doc = template.sub("YIELD_TITLE", self.title).sub("YIELD_AUTHOR",self.user.name).sub("YIELD_CONTENT", doc)
    
    open(temp, "w") do |file|
      file.write full_doc
    end

    system "xelatex -output-directory '#{self.folder}' '#{temp}'"
    system "xelatex -output-directory '#{self.folder}' '#{temp}'"
     
  end

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
