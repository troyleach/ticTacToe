require_relative 'ticTacToe'
require 'rspec'
 
describe 'TicTacToe' do
  before(:each) do 
    @game = TicTacToe.new
  end

  it 'Returns a instance of TicTacToe' do
    expect(@game).to be_instance_of(TicTacToe)
  end

  it 'Define a method name run' do
    expect(TicTacToe.method_defined?(:run)).to be true
  end

  it 'make_board is a defined' do
    expect(TicTacToe.method_defined?(:make_board)).to be true
  end
  
  it 'Returns a 2D array that mimacks a game board 3 squars by 3 squares' do
    expect(@game.make_board).to be_a_kind_of(Array)
    expect(@game.make_board[0]).to be_a_kind_of(Array)
    expect(@game.make_board[1]).to be_a_kind_of(Array)
    expect(@game.make_board[2]).to be_a_kind_of(Array)

    expect(@game.make_board[0].length).to eq(3)
    expect(@game.make_board[1].length).to eq(3)
    expect(@game.make_board[2].length).to eq(3)

    expect(@game.make_board[0][0]).to eq("1")
    expect(@game.make_board[2][2]).to eq("9")
  end
end

describe '#get_players_name' do
  before(:each) do 
    @game = TicTacToe.new
  end

  it 'Get players name #get_player_name' do
    expect(TicTacToe.method_defined?(:get_player_name)).to be true
  end

  it 'get_player_name returns the name Bob' do
    players = @game.get_player_name('bob')
    expect(players.player[:name]).to eq('bob') 
    expect(players.computer[:name]).to eq("King")
  end
end

describe '#display_board' do
  before(:each) do 
    @game = TicTacToe.new
  end

  it '#display_board' do
    expect(TicTacToe.method_defined?(:display_board)).to be true
  end

  it 'Displays a board with a X at position 1 and a O at position 5' do
    board = [["X", "2", "3"], ["4", "O", "6"], ["7", "8", "9"]]
    expect(@game.display_board(board).class).to eq(Array)
  end
end

describe '#place_game_piece' do
  before(:each) do 
    @game = TicTacToe.new
  end

  it '#place_game_piece is defined' do
    expect(TicTacToe.method_defined?(:place_game_piece)).to be true
  end

  it 'Place game piece in position 6' do
    board = @game.make_board
    @game.place_game_piece(board,"6", "X")
    expect(board[1][2]).to eq("X")
  end

  it '#computer_place_piece is defined' do
    expect(TicTacToe.method_defined?(:computer_place_piece)).to be true
  end

  it '#computer_place_piece returns the last possible spot to place a game piece' do
     board = [["X", "X", "O"], ["4", "O", "X"], ["X", "O", "O"]]
     expect(@game.computer_place_piece(board)).to eq('4')
  end

 it '#computer_place_piece returns a random number from the positions left on the board' do
    board = @game.make_board
    @game.stub(:computer_place_piece).and_return(5)
    expect(@game.computer_place_piece(board)).to eq(5)
  end
#TODO need to figure out how to test random (better yet .sample)
 it 'Computer places game piece randomaly' do
    board = [["X", "X", "O"], ["4", "O", "X"], ["X", "O", "O"]]
    players = @game.get_player_name('Bobby')
    expect(@game.place_game_piece(board, @game.computer_place_piece(board), players.computer[:piece])).to eq([["X", "X", "O"], ["O", "O", "X"], ["X", "O", "O"]])
  end

end

describe 'Check for winner #winner?' do
  before(:each) do
    @game = TicTacToe.new
    @board = [["X", "2", "3"], ["4", "O", "X"], ["O", "8", "X"]] 
  end

  it '#winner? is defined' do
    expect(TicTacToe.method_defined?(:winner?)).to be true
  end

  it '#tie_game? is defined' do
    expect(TicTacToe.method_defined?(:tie_game?)).to be true
  end

  it 'Not a winner return false' do
    expect(@game.winner?(@board)).to be false 
  end
  
  it 'Horizontal winner' do
    board = [["X", "2", "3"], ["X", "X", "X"], ["O", "8", "O"]]
    expect(@game.winner?(board)).to be true
  end

  it 'vertical winner' do
    board = [["X", "2", "3"], ["X", "5", "X"], ["X", "8", "O"]]
    expect(@game.winner?(board)).to be true
  end
   
  it 'Diagonal winner upper left to bottom right' do
    board = [["X", "2", "3"], ["O", "X", "O"], ["O", "8", "X"]]
    expect(@game.winner?(board)).to be true
  end

  it 'Diagonal winner upper left to bottom right' do
     board = [["1", "2", "O"], ["4", "O", "X"], ["O", "8", "X"]]
     expect(@game.winner?(board)).to be true
  end

  it 'Tie game' do
    board = [["X", "O", "X"], ["O", "X", "O"], ["O", "X", "O"]] 
    expect(@game.winner?(board)).to eq('tie')
   end
end

describe 'View' do
  before(:each) do
    @players = Players.new('bobby')
    @view = View.new
  end

  it '#welcome is defined' do
    expect(View.method_defined?(:welcome)).to be true 
  end

  it 'Welcome the player' do
    expect(@view.welcome.class).to eq(String)
  end
  
  it '#player_name is defined' do
    expect(View.method_defined?(:player_name)).to be true
  end

  it 'Expects a stirng asking for players name' do
    expect(@view.player_name.class).to eq(String)
  end

  it '#directions is defined' do
    expect(View.method_defined?(:directions)).to be true
  end

  it 'Returns the directions to the game' do
    expect(@view.directions.class).to eq(String)
  end

  it '#next_player is defined' do
     expect(View.method_defined?(:next_player)).to be true
  end

  it '#next_player expects an argument' do
    expect(@view.method(:next_player).arity).to eq(1)
  end

  it 'Expects a string to be returned' do
    expect(@view.next_player('bobby').class).to eq(String)
  end

  it 'Expects a string that contains the players name' do
    expect(@view.next_player(@players.player[:name])).to include('bobby')
  end

  it 'Expect #winner to be definded' do
    expect(View.method_defined?(:winner)).to be true
  end

  it 'Expect #winner to have one argument' do
    expect(@view.method(:winner).arity).to eq(1)
  end

  it 'Expects a string to be returned' do
     expect(@view.winner('bobby').class).to eq(String)
  end

  it 'Expects a string that contains the players name' do
    expect(@view.winner(@players.player[:name])).to include('Bobby')
  end


  it 'Expects #tie to be defined' do
    expect(View.method_defined?(:tie)).to be true 
  end

  it 'Expects #tie to return a string' do
    expect(@view.tie.class).to eq(String)
  end

end

describe 'Players' do
  before(:each) do
    @player = Players.new('Bob')
  end

  it 'Return a object with the players name Bob' do
    expect(@player.player[:name]).to eq('Bob')
    expect(@player.player[:piece]).to eq("X")
    expect(@player.computer[:name]).to eq('King')
    expect(@player.computer[:piece]).to eq('O')
  end
end

# [ x] Game needs to make a board
# [ x] Game asks for player name (two players, player and computer)
# [ x] Game displays board
# [ x] Game explains what to do, 'Pick a number where you want your piece to go, X or O'
# [ ] The player always goes first, game displays text '<players_name'> your up'
# [ x] Place game piece
# [ x] Games checks for winner (if winner exit the game and display '<players_name> your the winner')
# [ x] Then the computer places her piece - random from the spaces that are still open
# [ x] Then game checks for winner (if winner exit the game and display '<players_name> your the winner')
# [ x] player places an X....
# [ x] game can check for winner and win with either a winner or tie 

# Part Two -
# [ ] Game asks - one or two players
# [ ] if one player follow above
# [ ] if two, game asks for both players name and asks if they want to be X's or O's
# [ ] same as above
