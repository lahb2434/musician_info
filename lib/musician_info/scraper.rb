class MusicianInfo::Scraper

  def self.formatted_artist_name(input) #Formats input to specific http
    input.gsub(' ','+')
  end
  
  def self.artist(input) #Checks Artist is in Database
      Nokogiri::HTML(open("https://www.last.fm/music/#{formatted_artist_name(input)}"))
      
  end

  def self.similar_artist_list(input) #Find Artists similar to Artist searched.
    Nokogiri::HTML(open("https://www.last.fm/music/#{formatted_artist_name(input)}/+similar")).css('a.link-block-target').map{|x| x.text}
  end
  
  def self.artist_bio(input) #Finds Artist History
    Nokogiri::HTML(open("https://www.last.fm/music/#{formatted_artist_name(input)}/+wiki")).css('div.wiki-content p')[0].text.strip # artist biography  
  end

  def self.artist_members(input) #Finds Members of music ensemble
    members = Nokogiri::HTML(open("https://www.last.fm/music/#{formatted_artist_name(input)}/+wiki")).css('li.factbox-item li span').map{|x| x.text.strip}
    if members == []
      ['Unable To Retreive Member Information']# Members
    else
      members
    end
  end

  def self.wiki_formatted_artist_name(input) #Formats input to specific http
    input.gsub(' ','_')
  end

  def self.discography(input) #Finds Artist Discography based on web location and Name
    begin
      begin
        Nokogiri::HTML(open("https://en.wikipedia.org/wiki/#{wiki_formatted_artist_name(input)}_discography")).css('table.wikitable')[0].css('i a').map{|x| x.text.strip}
        rescue OpenURI::HTTPError
          begin
            Nokogiri::HTML(open("https://en.wikipedia.org/wiki/#{wiki_formatted_artist_name(input)}_(band)#Discography")).css('table.wikitable')[0].css('i a').map{|x| x.text.strip}
            rescue OpenURI::HTTPError
              begin
                Nokogiri::HTML(open("https://en.wikipedia.org/wiki/#{wiki_formatted_artist_name(input)}#Discography")).css('table.wikitable')[0].css('i a').map{|x| x.text.strip}
                rescue OpenURI::HTTPError
                  ['No Discography Information Available']

              end
          end
      end
    rescue NoMethodError
      ['Unable to retreive Information']
    end
  end
  
end  