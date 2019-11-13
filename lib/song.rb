require_relative '../config/environment'
require 'pry'

class Song 
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre
  @@all = []
  
  def initialize(song_name, artist_obj = nil, genre_obj = nil)
    @name = song_name
    self.artist = artist_obj if artist_obj != nil 
    self.genre = genre_obj if genre_obj != nil 
    # @@all.push(self)
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
  
  def self.create(song_name)
    created_song = Song.new(song_name)
    created_song.save 
    created_song 
  end 
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end 
  
  def genre=(genre)
    @genre = genre
    genre.songs.push(self) unless genre.songs.include?(self)
  end
  
  def genre
    @genre
  end 
  
  def self.find_by_name(song_name) 
    @@all.find {|song| song.name == song_name}
  end 
  
  def self.find_or_create_by_name(song_name) 
    self.find_by_name(song_name) || self.create(song_name)
  end 
  
  # describe "Song" do
  # describe ".new_from_filename" do
  #   it "initializes a song based on the passed-in filename" do
  #     song = Song.new_from_filename("Thundercat - For Love I Come - dance.mp3")

  #     expect(song.name).to eq("For Love I Come")
  #     expect(song.artist.name).to eq("Thundercat")
  #     expect(song.genre.name).to eq("dance")
  #   end

  #   it "invokes the appropriate Findable methods so as to avoid duplicating objects" do
  #     artist = Artist.create("Thundercat")
  #     genre = Genre.create("dance")

  #     expect(Artist).to receive(:find_or_create_by_name).and_return(artist)
  #     expect(Genre).to receive(:find_or_create_by_name).and_return(genre)

  #     song = Song.new_from_filename("Thundercat - For Love I Come - dance.mp3")

  #     expect(song.artist).to be(artist)
  #     expect(song.genre).to be(genre)
  #   end
  # end

  
  def self.new_from_filename(file_name)
    song_name = file_name.split(" - ")[1].to_s
    artist_name = file_name.split(" - ")[0].to_s
    genre = file_name.split(" - ")[2].split(".")[0].to_s
    
    if !self.find_by_name(song_name) 
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre)
    end
    song
    # binding.pry
  end 
  
  def self.create_from_filename(file_name)
    song = self.new_from_filename(file_name)
  end 

end 