# require '../db/mp3'

class MusicLibraryController
  attr_reader :path 

  def initialize(path = './db/mp3s')
    @path = path
    music_obj = MusicImporter.new(path)
    music_obj.import
  end 
  
  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    call_selection = gets.chomp 
    
    if call_selection == 'list_songs'
      list_songs 
      elsif call_selection == 'list_artists'
      list_artists
      elsif call_selection == 'list_genres'
      list_genres
      elsif call_selection == 'list_artist'
      list_songs_by_artist
      elsif call_selection == 'list_genre'
      list_songs_by_genre
      else call_selection == 'play_song'
      play_song
    end 
    self.call
  end 
  
  def list_songs 
    songs = Song.all.sort {|s1, s2| s1.name <=> s2.name}
    songs.each_with_index {|s, i| puts "#{i + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"}
  end 
 
  def list_artists
    artists = Artist.all.sort {|a1, a2| a1.name <=> a2.name}
    artists.each_with_index {|a, i| puts "#{i + 1}. #{a.name}"}
  end 
  
  def list_genres
    genres = Genre.all.sort {|g1, g2| g1.name <=> g2.name}
    genres.each_with_index {|g, i| puts "#{i + 1}. #{g.name}"}
  end 
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    
    songs = Song.all.sort{|a,b| a.name <=> b.name}
    songs = songs.select {|song| song.artist.name==artist}
    songs.each.with_index(1){|song,index| puts "#{index}. #{song.name} - #{song.genre.name}"}
  end 
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
    
    songs = Song.all.sort{|a,b| a.name <=> b.name}
    songs = songs.select {|song| song.genre.name==genre}
    songs.each.with_index(1){|song,index| puts "#{index}. #{song.artist.name} - #{song.name}"}
  end 
  
  def play_song
    puts "Which song number would you like to play?"
    song_num = gets.chomp.to_i
    
    songs = Song.all.sort{|a,b| a.name <=> b.name}
    if song_num > 0 && song_num <= songs.length
      puts "Playing #{songs[song_num-1].name} by #{songs[song_num-1].artist.name}" if(songs[song_num-1])
    end
  end 
end 

# new_obj = MusicLibraryController.new
# new_obj.list_songs



