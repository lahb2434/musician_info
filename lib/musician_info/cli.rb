
class MusicianInfo::CLI

  def call
    system('clear')
    no_more_fm
    puts ''
    puts '"Heard melodies are sweet, but those unheard are sweeter" - John Keats'
    start   
  end

  def start
      puts ''
      puts "               who have you been listening too lately?              "
      puts "<====~====♦ Enter Band name to search for similar artists ♦====~===>" 
      puts ''
      print "Band Name: " 
      user_input = input_band

      system('clear')

      puts "Give me second a to find that for you"
      puts ''
      
      find_similar_and_build_bands(user_input)
      band_list 
      loop_to_band_info
  
    end


  def find_similar_and_build_bands(band_name)
    begin
      MusicianInfo::Scraper.artist(band_name)
    rescue OpenURI::HTTPError
      puts "It appears there is no information for this band, Please enter a new band."
      start
    else
      new_guy = Array.new.push(band_name)
      MusicianInfo::Band.create_bands(new_guy)
      MusicianInfo::Band.create_bands(MusicianInfo::Scraper.similar_artist_list(band_name))
      MusicianInfo::Band.build_band
    end
  end

  def band_list
      puts "Your Band:"
      puts ""
      puts "1. #{MusicianInfo::Band.all[0].name}"
      puts ""
      puts "Bands that are similar:"
      puts ""
      MusicianInfo::Band.list_bands
  end

  def loop_to_band_info
    questions
    input = input_band
    system('clear')
    if MusicianInfo::Band.check_band(input)
        band_info(input)
        loop_to_band_info
    elsif 
        case input
        when 'List Bands'
          band_list
          loop_to_band_info
        when 'Start Over'
          clear_all
          start
        when 'Exit'
          exit_sequence
        else
          puts "Please enter a valid option."
          loop_to_band_info
        end
    end
  end
      

  def input_band
    gets.strip.split.map{|x| x.capitalize}.join(' ')
  end

  def clear_all
    MusicianInfo::Band.all.clear
    MusicianInfo::Member.all.clear
    MusicianInfo::Album.all.clear
  end

  def band_info(input)
    puts ''
    puts "Artist: #{MusicianInfo::Band.find_band(input).name}"
    puts ''
    puts "Genre: #{MusicianInfo::Band.find_band(input).genre}"
    puts ''
    puts "Members:"
    puts MusicianInfo::Member.list_members(input)
    puts ''
    puts 'Albums:'
    puts MusicianInfo::Album.list_album_by_artist(input)
    puts ''
    puts "Biography: #{MusicianInfo::Band.find_band(input).bio}"
    puts ''
  end

  def no_more_fm
   puts '███╗   ██╗ ██████╗                  
████╗  ██║██╔═══██╗                 
██╔██╗ ██║██║   ██║                 
██║╚██╗██║██║   ██║                 
██║ ╚████║╚██████╔╝                 
╚═╝  ╚═══╝ ╚═════╝                  
███╗   ███╗ ██████╗ ██████╗ ███████╗
████╗ ████║██╔═══██╗██╔══██╗██╔════╝
██╔████╔██║██║   ██║██████╔╝█████╗  
██║╚██╔╝██║██║   ██║██╔══██╗██╔══╝  
██║ ╚═╝ ██║╚██████╔╝██║  ██║███████╗
╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
███████╗███╗   ███╗                 
██╔════╝████╗ ████║                 
█████╗  ██╔████╔██║                 
██╔══╝  ██║╚██╔╝██║                 
██║██╗  ██║ ╚═╝ ██║██╗              
╚═╝╚═╝  ╚═╝     ╚═╝╚═╝'
  end  
  
def exit_sequence
  system('clear')
  puts ""
  puts "Hope you had a good time, Goodbye!"
  puts ""
  sleep(1)
  system('clear')
  no_more_fm
  sleep(1)
  system('clear')
  exit
end

def questions
  puts ''
  puts "What would you like to do?"
  puts ''
  puts "Enter 'Band Name' you would like to learn more about."
  puts "Enter 'List Bands' to show list of similar artists."
  puts "Enter 'Start Over' to go back to home screen and select another Artist to search."
  puts "Enter 'Exit' to leave program."
  puts ''
  print '?:'
end

end