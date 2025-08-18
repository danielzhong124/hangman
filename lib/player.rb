# frozen_string_literal: true

class Player
  attr_accessor :correct_letters, :letters_used, :mistakes

  MAX_MISTAKES = 6

  def initialize
    @correct_letters = []
    @letters_used = []
    @mistakes = 0
  end

  def new_game!(word_length)
    @correct_letters = Array.new(word_length, '_')
    @letters_used = []
    @mistakes = 0
  end

  def guess
    print 'Enter your guess: '
    guess = gets.chomp.downcase

    until valid_guess?(guess)
      print 'Invalid guess. Try again: '
      guess = gets.chomp.downcase
    end

    guess
  end

  def valid_guess?(guess)
    guess.match?(/^[a-z]$/) && !@letters_used.include?(guess)
  end

  def print_status
    puts @correct_letters.join(' ')
    puts "Incorrect guesses: #{@mistakes} / #{MAX_MISTAKES}"
    puts "Letters used: #{@letters_used.join}"
  end

  def lost?
    @mistakes >= MAX_MISTAKES
  end

  def won?
    !@correct_letters.include?('_')
  end
end
