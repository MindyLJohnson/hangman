module GameFiles
  def save_game
    @filename = "output/#{new_filename}.txt" if filename == ''
    Dir.mkdir('output') unless Dir.exist?('output')
    File.open(filename, 'w') { |file| file.puts save_variables }
  end

  def load_game
    if Dir.empty?('output')
      puts "\nThere aren't any saved games. Starting a new one.".gray.bold
    else
      display_saved_games
      game_selected = select_game
      return if game_selected == 'cancel'

      @filename = "output/#{game_selected}.txt"
      load_variables
    end
  end

  def save_variables
    JSON.dump({ word: word,
                clues: clues,
                guess: guess,
                previous_guesses: previous_guesses,
                display_guesses: display_guesses,
                remaining_guesses: remaining_guesses,
                body_parts: body_parts })
  end

  def load_variables
    saved_status = JSON.parse File.read filename
    @word = saved_status['word']
    @clues = saved_status['clues']
    @guess = saved_status['guess']
    @previous_guesses = saved_status['previous_guesses']
    @display_guesses = saved_status['display_guesses']
    @remaining_guesses = saved_status['remaining_guesses']
    @body_parts = saved_status['body_parts']
  end
end
