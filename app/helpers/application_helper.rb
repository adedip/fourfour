module ApplicationHelper
  def broadcast(channel, &block)
    move = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://192.168.1.185:9292/faye")
    Net::HTTP.post_form(uri,:message => move.to_json )
  end
end
