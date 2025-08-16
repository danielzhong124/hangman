require_relative 'player'

class Hangman
  FNAME = 'google-10000-english-no-swears.txt'
  attr_reader :dict, :word

  def initialize
    @dict = word_list
    @word = new_word
    @player = Player.new
  end

  def play
    @player.guess
  end

  def word_list(dict_file = FNAME)
    if File.exist?(dict_file)
      File.open(dict_file, 'r') do |file|
        return file.readlines().map(&:chomp).select { |word| word.length.between?(5, 12) }
      end
    else
      return []
    end
  end

  def new_word
    return @dict[rand(@dict.length)]
  end
end


