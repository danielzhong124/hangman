class Player
  
  def initialize
    @mistakes_left = 6
  end

  def reset!
    @mistakes_left = 6
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

  def penalize!
    @mistakes_left -= 1
  end
end