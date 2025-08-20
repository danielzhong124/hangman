# frozen_string_literal: true

require_relative 'game'

class Hangman
  DICT = 'google-10000-english-no-swears.txt'

  def initialize(dict = DICT)
    @words = load_words(dict)
  end

  def start_game
    @game = Game.new(rand_word)
    @game.play
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
end
