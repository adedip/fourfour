class GameController < ApplicationController

  def board
    if @board = Board.available
      @board.user_two = current_user
      broadcast "/board/#{@board.id}", "$('#user_two').html('#{@board.user_two.nickname}');"
    else
      @board = Board.new :user_one => current_user
    end
    @board.save
  end

  def move
    board = Board.find params[:id]
    if board.user_two.nil?
      flash[:notice] = "aspetta il secondo giocatore!"
    else
      if board.move current_user, params[:x], params[:y]
        board.save
        @user = (current_user == board.user_two) ? "user_two" : "user_one"
        @x = params[:x]
        @y = params[:y]
        @board = board
      end
    end
  end

  private
  def broadcast(channel, block)
    move = {:channel => channel, :data => block}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => move.to_json)
  end
end
