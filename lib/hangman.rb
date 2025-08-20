# frozen_string_literal: true

require_relative 'game'

class Hangman
  DICT = 'google-10000-english-no-swears.txt'

  def initialize(dict = DICT)
    @words = load_words(dict)
  end

  def start_option
    puts 'HANGMAN'
    puts '1. Load game'
    puts '2. New game'
    print '>> '

    option = gets.chomp
    until %w[1 2].include?(option)
      print '>> '
      option = gets.chomp
    end

    option
  end

  def run_game
    @game = start_option == '1' ? load_game : Game.new(rand_word)
    play_again = true

    while play_again
      @game.play
      play_again = play_again?
      @game = Game.new(rand_word) if play_again
    end

    puts 'Thanks for playing!'
  end

  def play_again?
    print 'Want to play again (y/n)? '
    option = gets.chomp.downcase

    until %w[y n].include?(option)
      print 'Want to play again (y/n)? '
      option = gets.chomp.downcase
    end

    option == 'y'
  end

  def load_words(dict)
    return [] unless File.exist?(dict)

    File.open(dict, 'r') do |file|
      file.readlines.map(&:chomp).select { |word| word.length.between?(5, 12) }
    end
  end

  def rand_word
    @words.empty? ? '' : @words.sample
  end

  def load_game
    File.exist?(Game::SAVE) ? YAML.load_file(Game::SAVE, permitted_classes: [Game]) : Game.new(rand_word)
  end
end
