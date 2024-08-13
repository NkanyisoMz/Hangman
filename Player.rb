class Player
  def initialize(name)
    @name = name
    @guesses = []
  end

  def process_guess(guess)
    if guess.length != 1 || @guesses.include?(guess) || guess !~ /[a-z]/
      puts "Invalid input. Please enter a single letter you haven't guessed before."
      nil
    else
      @guesses << guess
      guess
    end
  end
end

