
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

    # def self.list_albums #Finds and lists artists
    #     self.all.each{|artist| puts artist.album_name}
    # end

    def self.list_album_by_artist(artist) #Finds Band Albums by Artist Name
        band = self.all.select{|record| record.album_name if record.artist.name == artist}
        band.map{|record| record.album_name}
    end
end



    