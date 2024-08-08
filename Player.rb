class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end

  choice = gets.chomp
end
