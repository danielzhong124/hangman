# frozen_string_literal: true

class Game
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
      update_player!(guess)
    end

    puts lost? ? 'You lose!' : 'You win!'
    puts "The word was #{@word}."
  end

  def display_player
    puts "Incorrect guesses left: #{@strikes_left}"
    puts @correct_letters.join(' ')
    puts "Letters used: #{@used_letters.join}"
    print "\n"
  end

  def lost?
    @strikes_left <= 0
  end

  def won?
    !@correct_letters.include?('_')
  end

  def new_guess
    print 'Guess a letter: '
    guess = gets.chomp.downcase
    until valid_guess?(guess)
      puts 'Invalid guess. Try again.'
      print 'Guess a letter: '
      guess = gets.chomp.downcase
    end

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
end

# class Player
#   attr_accessor :correct_letters, :letters_used, :mistakes
#
#   MAX_MISTAKES = 6
#
#   def initialize
#     @correct_letters = []
#     @letters_used = []
#     @mistakes = 0
#   end
#
#   def new_game!(word_length)
#     @correct_letters = Array.new(word_length, '_')
#     @letters_used = []
#     @mistakes = 0
#   end
#
#   def guess
#     print 'Enter your guess: '
#     guess = gets.chomp.downcase
#
#     until valid_guess?(guess)
#       print 'Invalid guess. Try again: '
#       guess = gets.chomp.downcase
#     end
#
#     guess
#   end
#
#   def valid_guess?(guess)
#     guess.match?(/^[a-z]$/) && !@letters_used.include?(guess)
#   end
#
#   def print_status
#     puts @correct_letters.join(' ')
#     puts "Incorrect guesses: #{@mistakes} / #{MAX_MISTAKES}"
#     puts "Letters used: #{@letters_used.join}"
#   end
#
#   def lost?
#     @mistakes >= MAX_MISTAKES
#   end
#
#   def won?
#     !@correct_letters.include?('_')
#   end
# end
