module GameFiles
  def save_game
    @filename = "output/#{new_filename}.txt" if filename == ''
    Dir.mkdir('output') unless Dir.exist?('output')
    File.open(filename, 'w') { |file| file.puts save_status }
  end

  def load_game
    display_saved_games
    @filename = "output/#{select_game}.txt"
    load_status
  end

  def save_status
    JSON.dump({ word: word,
                clues: clues,
                guess: guess,
                previous_guesses: previous_guesses,
                remaining_guesses: remaining_guesses })
  end

  def load_status
    saved_status = JSON.parse File.read filename
    @word = saved_status['word']
    @clues = saved_status['clues']
    @guess = saved_status['guess']
    @previous_guesses = saved_status['previous_guesses']
    @remaining_guesses = saved_status['remaining_guesses']
  end
end
