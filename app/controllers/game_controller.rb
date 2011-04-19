class GameController < ApplicationController

  def board
    if @board = Board.available
      @board.user_two = current_user
    else
      @board = Board.new :user_one => current_user
    end
    @board.save
  end

  def move
    board = Board.find params[:id]
    board.move current_user, params[:x], params[:y]
    board.save
    @x = params[:x]
    @y = params[:y]
  end
end
