require_relative 'user_interface'

class Game
  include UserInterface

  DICTIONARY = File.readlines('5desk.txt')

  attr_reader :word, :clues, :guess, :previous_guesses, :remaining_guesses

  def initialize
    @word = generate_secret_word
    @clues = Array.new(word.length, '_')
    @guess = ''
    @previous_guesses = []
    @remaining_guesses = 6
  end

  def generate_secret_word
    word_list = DICTIONARY.collect do |word|
      word.chomp if word.length.between?(5, 12)
    end.compact
    word_list[rand(word_list.size)]
  end

  def play
    until game_over?
      update_display(clues, previous_guesses)
      @guess = new_guess
      update_clues(guess, previous_guesses)
    end
  end

  def game_over?
    word == clues.join('') || word == guess || remaining_guesses.zero?
  end
end
