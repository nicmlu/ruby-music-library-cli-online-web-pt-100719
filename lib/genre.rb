require_relative '../config/environment'

class Genre 
  extend Concerns::Findable
  attr_accessor :name, :songs  
  @@all = []
  
  def initialize(genre)
    @name = genre
    @songs = []
  end 
  
  def self.all
    @@all
  end 
  
  def self.destroy_all
    @@all.clear
  end
  
  def save 
    @@all.push(self)
  end 
  
  def self.create(genre)
    created_genre = self.new(genre)
    created_genre.save 
    created_genre 
  end 
  
  def songs 
    @songs
  end 
  
  def artists
    all_artists = @songs.collect {|song| song.artist}.uniq
    all_artists
  end 

end 