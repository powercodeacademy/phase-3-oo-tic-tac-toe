require "pry"

class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [0, 3, 6],
    [0, 4, 8],
    [1, 4, 7],
    [2, 5, 8],
    [3, 4, 5],
    [6, 7, 8],
    [2, 4, 6],
  ].freeze

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts [
      " #{@board[0]} │ #{@board[1]} │ #{@board[2]} ",
      "───┼───┼───",
      " #{@board[3]} │ #{@board[4]} │ #{@board[5]} ",
      "───┼───┼───",
      " #{@board[6]} │ #{@board[7]} │ #{@board[8]} ",
    ]
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    return true if @board[index] == "X" || @board[index] == "O"

    false
  end

  def valid_move?(index)
    return true if index.between?(0, 8) && !position_taken?(index)

    false
  end

  def turn_count
    9 - @board.count(" ")
  end

  def current_player
    return "X" if turn_count.even?

    "O"
  end

  def turn
    puts "It's #{current_player}'s turn, enter the space you want to take!"
    index = input_to_index(gets.chomp)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "That move is not allowed, choose another."
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.find do |win_con|
      token = @board[win_con.first]
      (token == "X" || token == "O") && win_con.all? { |space| @board[space] == token }
    end
  end

  def full?
    @board.count(" ").zero?
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || full?
  end

  def winner
    if won?
      return "O" if turn_count.even?

      "X"
    end
  end

  def play
    turn until over?

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
