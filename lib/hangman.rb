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

  #   def get_positions(letter)
  #     indices = []
  #
  #     index = @word.index(letter)
  #     until index.nil?
  #       indices.push(index)
  #       index = @word.index(letter, index + 1)
  #     end
  #
  #     indices
  #   end
  #
  #   def update_player!(letter)
  #     @player.letters_used.push(letter)
  #
  #     index = @word.index(letter)
  #     if index.nil?
  #       @player.mistakes += 1
  #       return
  #     end
  #
  #     until index.nil?
  #       @player.correct_letters[index] = @word[index]
  #       index = @word.index(letter, index + 1)
  #     end
  #   end
end
