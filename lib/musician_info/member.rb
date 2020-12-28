
class MusicianInfo::Member

    attr_accessor :name, :band

    @@all = []

    def initialize(name, band = nil)
        @name = name
        @band = band
        @@all << self
    end

    def self.all
        @@all
    end

    def self.list_members(input)
        self.all.select{|x| x.name if x.band.name == input}.map{|x| x.name}
    end

    def self.clear
        self.all.clear
    end

end