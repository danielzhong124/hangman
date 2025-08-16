class Player

  def initialize
    @correct_letters = []
    @incorrect_letters = []
  end

  def new_game!(word_length)
    @correct_letters = Array.new(word_length, '_')
    @incorrect_letters = []
  end

  def guess
    print 'Guess a letter: '
    letter = gets.chomp.downcase

    until letter.match?(/^[a-z]$/)
      print 'Invalid guess. Try again: '
      letter = gets.chomp.downcase
    end

    return letter
  end

  def mistakes_left
    return 6 - @incorrect_letters.length
  end

  def correct_letters
    return @correct_letters.join(' ')
  end
end