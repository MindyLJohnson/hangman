require 'json'

module UserInterface
  def new_game?
    puts 'Would you like to load a saved game? (Yes/No)'.gray.bold
    gets.chomp.downcase[0] != 'y'
  end

  def display_saved_games
    print "\nSaved Games:\n".bold
    Dir.glob('*.txt', base: 'output').each do |file|
      puts file.delete_suffix '.txt'
    end
    print "\n"
  end

  def select_game
    puts 'Choose game to load.'.gray.bold
    gets.chomp.downcase
  end

  def new_filename
    puts 'Enter a new filename to save your game.'.gray.bold
    gets.chomp.downcase
  end

  def new_guess
    puts 'Make a guess!'.gray.bold
    puts '(Enter SAVE to save your game or QUIT to quit.)'.gray.bold
    gets.chomp.downcase
  end

  def update_display(clues, display_guesses)
    print hangman
    print 'Word: '
    print_letters(clues)
    print 'Previous Guesses: '
    print_letters(display_guesses)
  end

  def hangman
    puts <<-HEREDOC

          __________
          |        |
          |       #{body_parts[0]}
          |       #{body_parts[2]}#{body_parts[1]}#{body_parts[3]}
          |       #{body_parts[4]} #{body_parts[5]}
        __|__

    HEREDOC
  end

  def print_letters(input)
    input.each { |letter| print " #{letter}" }
    print "\n\n"
  end
end
