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