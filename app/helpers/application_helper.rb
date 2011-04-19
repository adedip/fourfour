module ApplicationHelper
  def broadcast(channel, &block)
    move = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri,:message => move.to_json )
  end
  
  def new_player(channel, player)
    second_player = {:channel => channel, :data => player}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri,:message => second_player.to_json )
  end
end
