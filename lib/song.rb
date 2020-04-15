require 'pry'


class Song

    @@all = []

    attr_accessor :name
    attr_reader :artist, :genre


    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist= artist if artist
        self.genre= genre if genre
    end

    def self.all 
        @@all
    end

    def self.destroy_all 
        self.all.clear
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def self.find_by_name(name)
        @@all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end 

    def self.new_from_filename(filename)
        array = filename.split(" - ")
        artist, name, genre = array[0], array[1], array[2].gsub( ".mp3" , "")
        genre = Genre.find_or_create_by_name(genre)
        artist = Artist.find_or_create_by_name(artist)
        new(name,artist,genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).tap {|fm| fm.save}
    end


    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist 
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre 
        if !(genre.songs.include?(self))
        genre.songs << self
        end
    end

end