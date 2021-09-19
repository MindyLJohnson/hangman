require_relative 'user_interface'

class Game
  include UserInterface

  DICTIONARY = File.readlines('5desk.txt')

  attr_reader :word, :clues, :guess, :previous_guesses, :remaining_guesses,
              :filename

  def initialize
    @word = generate_secret_word
    @clues = Array.new(word.length, '_')
    @guess = ''
    @previous_guesses = []
    @remaining_guesses = 6
    @filename = ''
  end

  def generate_secret_word
    word_list = DICTIONARY.collect do |word|
      word.chomp if word.length.between?(5, 12)
    end.compact
    word_list[rand(word_list.size)]
  end

  def play
    setup
    until game_over?
      update_display(clues, previous_guesses)
      @guess = new_guess
      if guess == 'save'
        p save_game
        next
      end
      update_clues(guess, previous_guesses)
    end
  end

  def setup
    load_game unless new_game?
  end

  def update_clues(guess, previous_guesses)
    temp_clues = clues.join('')
    clues.each_index { |index| clues[index] = guess if word[index] == guess }
    previous_guesses << guess if guess.length == 1
    @remaining_guesses -= 1 if temp_clues == clues.join('')
  end

  def game_over?
    word == clues.join('') || word == guess || remaining_guesses.zero?
  end

  def save_game
    @filename = "output/#{new_filename}.txt" if filename == ''
    Dir.mkdir('output') unless Dir.exist?('output')
    File.open(filename, 'w') { |file| file.puts save_status }
  end

  def load_game
    display_saved_games
    @filename = "output/#{select_game}.txt"
    load_status
  end

  def save_status
    JSON.dump({ word: word,
                clues: clues,
                guess: guess,
                previous_guesses: previous_guesses,
                remaining_guesses: remaining_guesses })
  end

  def load_status
    saved_status = JSON.parse File.read filename
    @word = saved_status['word']
    @clues = saved_status['clues']
    @guess = saved_status['guess']
    @previous_guesses = saved_status['previous_guesses']
    @remaining_guesses = saved_status['remaining_guesses']
  end
end
