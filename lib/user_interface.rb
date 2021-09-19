require 'json'

module UserInterface
  def new_game?
    puts 'Would you like to load a saved game? (Yes/No)'
    gets.chomp.downcase[0] != 'y'
  end

  def display_saved_games
    print "\n"
    Dir.entries('output').reverse.drop(2).each do |file|
      puts file.delete '.txt'
    end
    print "\n"
  end

  def select_game
    puts 'Choose game to load.'
    gets.chomp.downcase
  end

  def new_filename
    puts 'Enter a new filename to save your game.'
    gets.chomp.downcase
  end

  def new_guess
    puts 'Make a guess! Or enter SAVE to save your game.'
    gets.chomp.downcase
  end

  def update_display(clues, previous_guesses)
    print hangman
    print 'Word: '
    print_letters(clues)
    print 'Previous Guesses: '
    print_letters(previous_guesses)
    print "Remaining Guesses: #{remaining_guesses}\n\n"
  end

  def hangman
    puts <<-HEREDOC

          __________
          |        |
          |       \u32E1
          |       /|\\
          |        |
          |       / \\
        __|__

    HEREDOC
  end

  def print_letters(input)
    input.each { |letter| print " #{letter}" }
    print "\n\n"
  end
end
