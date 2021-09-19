require 'json'

module UserInterface
  def new_guess
    puts 'Make a guess! Or enter SAVE to save your game.'
    gets.chomp.downcase
  end

  def update_display(clues, previous_guesses)
    print 'Word: '
    print_letters(clues)
    print 'Previous Guesses: '
    print_letters(previous_guesses)
    print "Remaining Guesses: #{remaining_guesses}\n\n"
  end

  def print_letters(input)
    input.each { |letter| print " #{letter}" }
    print "\n\n"
  end

  def new_filename
    puts 'Enter a new filename to save your game.'
    gets.chomp
  end
end
