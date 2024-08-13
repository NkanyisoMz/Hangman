require_relative 'Hangman'
require_relative 'Player'
require 'yaml'


class Game
  def initialize
    @hangman = nil
    @player = nil
  end

  def start
    puts "Welcome to Hangman"
    puts "Would you like to load a saved game? (yes/no)"
    if gets.chomp.downcase == "yes"
      load_game
    else
      new_game
    end

    play_game
  end

  def new_game
    puts "Enter your name: "
    @player = Player.new(gets.chomp)
    @hangman = Hangman.new
    @hangman.start
  end

  def play_game
    until @hangman.check_winner
      @hangman.display_word
      puts "Incorrect guesses: #{@hangman.incorrect_guesses.join(', ')}"
      puts "Press '!' to save the game or make a guess: "
      input = gets.chomp.downcase
      if input == '!'
        save_game
        puts "Game saved!"
        break  # Exit the loop after saving
      else
        guess = @player.process_guess(input)
        if guess  # Only process if guess is valid
          @hangman.check_correct_letters(guess)
        end
      end
    end
  end

  def save_game
    File.open('saved_game.yaml', 'w') { |file| file.write(YAML.dump(self)) }
  end

  def load_game
    if File.exist?('saved_game.yaml')
      data = File.read('saved_game.yaml')
      saved_game = YAML.safe_load(data, permitted_classes: [Game, Hangman, Player], aliases: true)
      @hangman = saved_game.instance_variable_get(:@hangman)
      @player = saved_game.instance_variable_get(:@player)
      puts "Game loaded!"
    else
      puts "No saved game found. Starting a new game."
      new_game
    end
  end
end

game = Game.new
game.start

