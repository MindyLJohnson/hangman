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

  def update_clues(guess, previous_guesses)
    temp_clues = clues.join('')
    clues.each_index { |index| clues[index] = guess if word[index] == guess }
    previous_guesses << guess if guess.length == 1
    @remaining_guesses -= 1 if temp_clues == clues.join('')
  end

  def new_filename
    puts 'Enter a new filename to save your game.'
    gets.chomp
  end

  def current_status
    JSON.dump({ word: word,
                clues: clues,
                guess: guess,
                previous_guesses: previous_guesses,
                remaining_guesses: remaining_guesses })
  end
end
