class GameController < ApplicationController

  def board
    if @board = Board.available
      @board.user_two = current_user
      broadcast "/board/#{@board.id}", "$('#user_two').html('#{@board.user_two.nickname}');"
      #start_count_down
    else
      @board = Board.new :user_one => current_user
    end
    @board.save
  end

  def move
    board = Board.find params[:id]
    if board.user_two.nil?
    render(:update) { |page| page.alert("wait for user two") }
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
    uri = URI.parse("http://192.168.1.75:9292/faye")
    Net::HTTP.post_form(uri, :message => move.to_json)
  end

  def start_count_down
    x = 5
    while x >= 0 do
      x -=1
      if x == 0
      broadcast "/board/#{@board.id}", "$('#ready').html('GO!!!');"
      else
      broadcast "/board/#{@board.id}", "$('#ready').html('#{x+1}');"
      end
      sleep 3
    end
  end
end
