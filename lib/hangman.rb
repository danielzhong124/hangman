# frozen_string_literal: true

require_relative 'player'

class Hangman
  FNAME = 'google-10000-english-no-swears.txt'
  attr_reader :dict, :word

  def initialize(dict_file = FNAME)
    @dict = load_dict(dict_file)
    @player = Player.new
    @word = ''
  end

  def play
    @word = rand_word
    @player.new_game!(@word.length)

    until @player.lost? || @player.won?
      @player.print_status
      guess = @player.guess
      update_player!(guess)
    end

    puts @player.lost? ? 'You lose!' : 'You win!'
    puts "The word was #{@word}"
  end

  def load_dict(dict_file)
    return [] unless File.exist?(dict_file)

    File.open(dict_file, 'r') do |file|
      return file.readlines.map(&:chomp).select { |word| word.length.between?(5, 12) }
    end
  end

  def rand_word
    @dict ? @dict[rand(@dict.length)] : @word
  end

  def get_positions(letter)
    indices = []

    index = @word.index(letter)
    until index.nil?
      indices.push(index)
      index = @word.index(letter, index + 1)
    end

    indices
  end

  def update_player!(letter)
    @player.letters_used.push(letter)

    index = @word.index(letter)
    if index.nil?
      @player.mistakes += 1
      return
    end

    until index.nil?
      @player.correct_letters[index] = @word[index]
      index = @word.index(letter, index + 1)
    end
  end
end
