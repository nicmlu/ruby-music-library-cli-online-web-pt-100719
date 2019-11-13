require_relative '../config/environment'

class Artist 
  extend Concerns::Findable
  attr_accessor :name, :songs 
  @@all = []
  
  def initialize(artist_name)
    @name = artist_name
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
  
  def self.create(artist_name)
    created_artist = self.new(artist_name)
    created_artist.save 
    created_artist 
  end 
  
  def add_song(song_obj)
    song_obj.artist = self unless song_obj.artist != nil 
    @songs.push(song_obj) unless @songs.include?(song_obj)
  end 
  
  def genres 
  
    all_genres = @songs.collect {|song| song.genre}.uniq
    all_genres
    
  end 

end 