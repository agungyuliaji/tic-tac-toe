class GameManager
  # Accessor for winner to get or set the winner of the game
  attr_accessor :winner

  # Initializes the GameManager with a session and sets up default game values
  def initialize(session)
    @session = session
    setup_game_defaults
  end

  # Sets the names of the players, defaulting to "Player 1" and "Player 2" if not provided
  def set_player_names(player_1_name, player_2_name)
    @session[:player_1_name] = player_1_name.presence || "Player 1"
    @session[:player_2_name] = player_2_name.presence || "Player 2"
  end

  # Checks if both player names are filled
  def ready?
    @session[:player_1_name].present? && @session[:player_2_name].present?
  end

  # Returns the current state of the board from the session
  def board
    @session[:board]
  end

  def board=(value)
    @session[:board] = value
  end

  def board_text
    if winner == "Draw"
      "Draw"
    elsif winner.present?
      "#{winner} Wins!"
    else
      "(#{current_player}) #{current_player_name} turn"
    end
  end

  # Returns the symbol ('X' or 'O') of the current player
  def current_player
    @session[:current_player]
  end

  # Returns the name of the current player based on the current_player symbol
  def current_player_name
    current_player == "X" ? @session[:player_1_name] : @session[:player_2_name]
  end

  # Checks the board for winning combinations or a draw
  def check_combination
    return unless self.ready?

    winning_combinations.find do |combination|
      if combination.all? { |index| board[index] == "X" }
        self.winner = "X"
      elsif combination.all? { |index| board[index] == "O" }
        self.winner = "O"
      end
    end

    # Sets winner to 'Draw' if the board is full and no winner has been determined
    if self.winner.blank? && board.all? { |cell| cell.present? }
      self.winner = 'Draw'
    end
  end

  # Switches the current player and updates the current_player_name accordingly
  def switch_player
    @session[:current_player] = current_player == "X" ? "O" : "X"
  end

  # Resets the board and current player to start a new game, also resets the winner
  def restart
    @session[:board] = Array.new(9)
    @session[:current_player] = "X"
    self.winner = nil
  end

  # Clears all game-related session data and resets the winner
  def reset
    [:player_1_name, :player_2_name, :board, :current_player].each do |key|
      @session.delete(key)
    end
    self.winner = nil
  end

  private

  # Sets default values for the game
  def setup_game_defaults
    @session[:board] ||= Array.new(9)
    @session[:current_player] ||= "X"
  end

  # Defines all possible winning combinations on the board
  def winning_combinations
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end
end
