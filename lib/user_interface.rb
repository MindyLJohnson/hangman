module UserInterface
  def new_guess
    puts 'Make a guess!'
    gets.chomp
  end

  def update_display(clues)
    clues.each { |letter| print " #{letter}" }
    print "\n"
  end

  def update_clues(guess)
    clues.each_index { |index| clues[index] = guess if word[index] == guess }
  end
end
