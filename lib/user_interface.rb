module UserInterface
  def new_guess
    puts 'Make a guess!'
    gets.chomp
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

  def update_clues(guess, previous_guesses)
    temp_clues = clues.join('')
    clues.each_index { |index| clues[index] = guess if word[index] == guess }
    previous_guesses << guess if guess.length == 1
    @remaining_guesses -= 1 if temp_clues == clues.join('')
  end
end
