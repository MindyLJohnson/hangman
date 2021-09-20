require_relative 'user_interface'
require_relative 'color'
require_relative 'game_files'

class Game
  include UserInterface
  include GameFiles

  DICTIONARY = File.readlines('5desk.txt')
  HANGMAN = ["\u32E1", '|', '/', '\\', '/', '\\'].freeze

  attr_reader :word, :clues, :guess, :previous_guesses, :display_guesses,
              :remaining_guesses, :filename, :body_parts

  def initialize
    @word = generate_secret_word
    @clues = Array.new(word.length, '_')
    @guess = ''
    @previous_guesses = []
    @display_guesses = []
    @remaining_guesses = 6
    @filename = ''
    @body_parts = Array.new(5, ' ')
  end

  def generate_secret_word
    word_list = DICTIONARY.collect do |word|
      word.chomp if word.length.between?(5, 12) && word[0] == word[0].downcase
    end.compact
    word_list[rand(word_list.size)]
  end

  def start
    load_game unless new_game?
    play
    if game_over?
      update_display(word.split(''), display_guesses)
      conclusion
    else
      puts "\nBye! Come back soon!\n".magenta.bold
    end
  end

  def play
    until game_over?
      update_display(clues, display_guesses)
      @guess = new_guess
      break if guess == 'quit'

      guess == 'save' ? save_game : update_guesses
    end
  end

  def update_guesses
    if unique_guess?
      update_clues
      previous_guesses << guess
    else
      puts "\nYou already made that guess!".yellow.bold
    end
  end

  def unique_guess?
    previous_guesses.none? guess
  end

  def update_clues
    temp_clues = clues.join('')
    clues.each_index { |index| clues[index] = guess if word[index] == guess }
    temp_clues == clues.join('') ? wrong_guess : right_guess
  end

  def right_guess
    display_guesses << guess.green if guess.length == 1
  end

  def wrong_guess
    @remaining_guesses -= 1
    display_guesses << guess.red if guess.length == 1
    update_gallows
  end

  def update_gallows
    @body_parts[5 - remaining_guesses] = HANGMAN[5 - remaining_guesses].yellow
  end

  def game_over?
    word == clues.join('') || word == guess || remaining_guesses.zero?
  end

  def conclusion
    if word == clues.join('') || word == guess
      puts "CONGRATS!! You guessed the word!\n".green.bold
    else
      puts 'Game over! You have been hanged.'.red.bold
      puts "The word was #{word.cyan.bold}.\n"
    end
  end
end
