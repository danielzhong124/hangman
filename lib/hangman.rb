require_relative 'player'

class Hangman
  FNAME = 'google-10000-english-no-swears.txt'
  attr_reader :dict, :word

  def initialize(dict_file = FNAME)
    @dict = word_list(dict_file)
    @player = Player.new
    @word = ''
  end

  def play
    @word = rand_word
    @player.new_game!(@word.length)
    puts @player.correct_letters
  end

  def word_list(dict_file)
    if File.exist?(dict_file)
      File.open(dict_file, 'r') do |file|
        return file.readlines().map(&:chomp).select { |word| word.length.between?(5, 12) }
      end
    else
      return []
    end
  end

  def rand_word
    return @dict[rand(@dict.length)]
  end
end


