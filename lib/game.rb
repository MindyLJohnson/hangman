class Game
  DICTIONARY = File.readlines('5desk.txt')

  attr_reader :word, :clues, :guess

  def initialize
    @word = generate_secret_word
    @clues = Array.new(word.length, '_')
  end

  def generate_secret_word
    word_list = DICTIONARY.collect do |word|
      word.chomp if word.length.between?(5, 12)
    end.compact
    word_list[rand(word_list.size)]
  end

  def play
    until game_over?
      update_display
      @guess = new_guess
      update_clues(guess)
    end
  end

  def update_display
    clues.each { |letter| print " #{letter}" }
    print "\n"
  end

  def new_guess
    puts 'Make a guess!'
    gets.chomp
  end

  def update_clues(guess)
    clues.each_index { |index| clues[index] = guess if word[index] == guess }
  end

  def game_over?
    word == clues.join('')
  end
end
