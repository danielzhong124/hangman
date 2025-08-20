# frozen_string_literal: true

require_relative 'lib/hangman'

system('cls')
hangman = Hangman.new
hangman.start_game
