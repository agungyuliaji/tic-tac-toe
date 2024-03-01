class GamesController < ApplicationController
  before_action :set_gm

  def index
    @gm.check_combination
  end

  def set_names
    @gm.set_player_names(params[:player_1_name], params[:player_2_name])
    redirect_to root_path
  end

  def move
    board = @gm.board
    index = params[:index].to_i

    if board[index].blank?
      board[index] = @gm.current_player
      @gm.switch_player
    end

    redirect_to root_path
  end

  def restart
    @gm.restart
    redirect_to root_path
  end

  def reset
    @gm.reset
    redirect_to root_path
  end

  private

  def set_gm
    @gm = GameManager.new(session)
  end
end
