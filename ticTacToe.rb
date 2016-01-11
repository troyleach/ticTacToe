# TODO'S need to do validations
# need to finsh tests
# add logic to play again and write tests
require 'pry'
class TicTacToe

  def run
    view = View.new
    puts view.welcome
    print view.player_name 
    get_player_name(gets.chomp)
    make_board
    display_board(@board)
    puts view.directions
    while true 
      @players.cycle do |player|
        if player.player[:name] == 'King'
          puts view.next_player(player.player[:name])
          place_game_piece(@board, computer_place_piece(@board), player.player[:piece])
        else
          puts view.next_player(player.player[:name]) 
          place_game_piece(@board, gets.chomp, player.player[:piece])
        end
       if winner?(@board)
         if winner?(@board) == 'tie'
           puts view.tie
           exit
         end
         puts view.winner(player.player[:name])
         display_board(@board)
         exit 
       end
       display_board(@board)
      end
    end 
   end
  # @board = Array.new(3, Array.new(3, "_|"))
  def make_board
    @board = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
    # board = Array.new(3, Array.new(3, (1..9)))
  end

  def get_player_name(name)
    @players = []
    @players << Players.new(name)
    @players << Computer.new 
  end

  def display_board(board)
    board.each do |column|
      puts column.map { |row| row }.join(" ")
    end
  end

 
  def place_game_piece(board, position, piece)
    board.each do |row|
      row.each do |cell|
        cell.gsub!(position, piece)
      end
    end
    return board
  end

  def computer_place_piece(board)
   flat_board = board.flatten
   temp_array = []
   flat_board.each do |position|
     temp_array << position if position.match(/1|2|3|4|5|6|7|8|9/)
    end
     temp_array.sample
  end

  def winner?(board)
    if board.map do |row|
        return true if row.join().match(/X{3}|O{3}/)
       end
    end

    if board.transpose.map do |col|
         return true if col.join().match(/X{3}|O{3}/)
       end
    end

    if temp_array = (0..2).collect { |i| board[i][0+i] }
      return true if temp_array.join().match(/X{3}|O{3}/)
    end

    if temp_array = (0..2).collect { |i| board[i][2-i] }
      return true if temp_array.join().match(/X{3}|O{3}/)
    end

    if tie_game?(board)
      return 'tie'
    end

    return false 
  end

  def tie_game?(board)
    flatten_board = board.flatten
    temp_array = []
    flatten_board.each do |element|
      temp_array << element if element.match(/1|2|3|4|5|6|7|8|9/)
    end
    temp_array.empty? 
  end

end

class Players
  attr_reader :player, :peice
  def initialize(name)
    @player = {"name": name, "piece": 'X'}
  end
end

#TODO'S computer class NOT tested
class Computer
  attr_reader :player, :peice
  def initialize
    @player = {"name": "King", "piece": 'O'}
  end
end

class View
  def welcome
   'Welcome to my Tic Tac Toe game!!'
  end

  def player_name
    return 'What is your name? '
  end

  def next_player(player)
    return 'Your turn ' + player + ', pick a number' 
  end

  def winner(player)
    return player.capitalize + ' your the winner'
  end

  def tie
    return 'This game seems to have ended in a tie'
  end
  
  def directions
    return 'When the game starts a new board will be displayed./nNumbers 1-9 will be displayed on the barod./nWhere ever you would like the place a game piece/njust select the corresponding number!'
  end
end

TicTacToe.new.run
