
class MusicianInfo::Band

    attr_accessor :name, :genre, :bio

    @@all = []

    def initialize(name, genre=nil, bio=nil)
        @name = name
        @genre = genre
        @bio = bio
        @@all << self
    end
 
    def self.all
        @@all 
    end

    def self.build_band #Creates Bands and Band Info Objects
        self.all.map do |band|
            band.bio = MusicianInfo::Scraper.artist_bio(band.name)
            band.genre = MusicianInfo::Scraper.artist(band.name).css('section.catalogue-tags ul li a').first.text.capitalize
            band.create_members(MusicianInfo::Scraper.artist_members(band.name))
            band.create_album(MusicianInfo::Scraper.discography(band.name))
        end
    end

    def self.create_bands(bands)
        bands.map do |band_name|
            self.new(band_name)
        end
    end

    def self.find_band(band_name)
        self.all.detect{|x| x.name == band_name}
    end

    def create_members(members)
        members.map do |member|
            MusicianInfo::Member.new(member, self)
        end
    end

    def create_album(albums)
        albums.map do |album|
            MusicianInfo::Album.new(album, self)
        end
    end
      
    def self.list_bands #List Bands with index position
        self.all[1..-1].map.with_index(2){|band, position| puts "#{position}. #{band.name}"}
    end

    def self.check_band(band_name)
        self.all.map{|x| x.name}.include?(band_name)
    end 

    def self.clear_bands_array
        self.all.clear
    end
      
end