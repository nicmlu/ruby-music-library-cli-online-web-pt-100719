class MusicImporter
  attr_reader :path
  
  def initialize(path)
    @path = path 
  end 
  
  def files
    Dir.children(path)
  end 
  
  def import
    self.files.each {|file_name| Song.create_from_filename(file_name)}
  end 
  
end 