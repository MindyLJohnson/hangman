class Game
  DICTIONARY = File.readlines('5desk.txt')

  attr_reader :word, :clues

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
      puts "Make a guess!"
      @guess = gets.chomp
      update_clues
    end
  end

  def update_display
    clues.each { |letter| print " #{letter}" }
    print "\n"
  end

  def update_clues
    
  end

  def game_over?
    word == clues.join('')
    true
  end
end
