

class Genre 
    extend Concerns::Findable
    

    @@all = []

    attr_accessor :name
    attr_reader :songs

    def initialize(name)
        @name = name 
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        n_genre = Genre.new(name)
        n_genre.save
        n_genre
    end

    def save
        @@all << self
        # ask why this won't work w Genre.
    end

    def artists
        songs.collect {|song| song.artist}.uniq
    end
















end
