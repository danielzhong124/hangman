# frozen_string_literal: true

require 'yaml'

class Game
  SAVE = 'saves/saved_game.yaml'

  def initialize(word)
    @word = word
    @correct_letters = Array.new(@word.length, '_')
    @used_letters = []
    @strikes_left = 6
  end

  def play
    until lost? || won?
      system('cls')
      display_player
      guess = new_guess
      guess == '!' ? save_game : update_player!(guess)
    end

    puts lost? ? 'You lose!' : 'You win!'
    puts "The word was #{@word}."
  end

  def display_player
    puts "Incorrect guesses left: #{@strikes_left}"
    puts @correct_letters.join(' ')
    puts "Letters used: #{@used_letters.join}"
  end

  def lost?
    @strikes_left <= 0
  end

  def won?
    !@correct_letters.include?('_')
  end

  def new_guess
    print "Enter your guess (or '!' to save and quit): "
    guess = gets.chomp.downcase
    until guess == '!' || valid_guess?(guess)
      print "Enter your guess (or '!' to save and quit): "
      guess = gets.chomp.downcase
    end

    print "\n"
    guess
  end

  def valid_guess?(guess)
    ('a'..'z').include?(guess) && !@used_letters.include?(guess)
  end

  def update_player!(letter)
    @used_letters.push(letter)

    index = @word.index(letter)
    if index.nil?
      @strikes_left -= 1
    else
      until index.nil?
        @correct_letters[index] = @word[index]
        index = @word.index(letter, index + 1)
      end
    end
  end

  def save_game
    File.open(SAVE, 'w') { |file| YAML.dump(self, file) }
    puts 'Game saved!'
    exit(0)
  end
end
