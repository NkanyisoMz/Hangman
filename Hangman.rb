class Hangman
  attr_reader :incorrect_guesses

  def initialize
    @word = nil
    @guessed_letters = []
    @incorrect_guesses = []
    @allocated_iterations = 10
  end

  def start
    words = File.readlines('google-10000-english-no-swears.txt')
    @word = words.select { |word| word.strip.length >= 5 && word.strip.length <= 12 }.sample.strip
  end

  def display_word
    display = @word.chars.map { |letter| @guessed_letters.include?(letter) ? letter : '_' }
    puts display.join(' ')
  end

  def check_correct_letters(guess)
    if @word.include?(guess)
      @guessed_letters << guess
      puts "Correct! '#{guess}' is in the word."
    else
      @incorrect_guesses << guess
      puts "Sorry, '#{guess}' is not in the word."
    end
  end

  def check_winner
    if @word.chars.all? { |letter| @guessed_letters.include?(letter) }
      puts "Congratulations, you won!"
      true
    elsif @incorrect_guesses.length >= @allocated_iterations
      puts "Sorry, you didn't guess the word within the allocated attempts. The word was '#{@word}'."
      true
    else
      false
    end
  end
end
