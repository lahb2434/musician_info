
class MusicianInfo::Album

    attr_accessor :album_name, :artist

    @@all = []

    def initialize(album_name, artist = nil)
        @album_name = album_name
        @artist = artist
        @@all << self
    end

    def self.all
        @@all
    end

    def self.list_albums
        self.all.each{|x| puts x.album_name}
    end

    def self.list_album_by_artist(artist)
        self.all.select{|x| x.album_name if x.artist.name == artist}.map{|x| x.album_name}
    end
end



    