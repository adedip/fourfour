$(function(){
    var faye = new Faye.Client('http://192.168.1.185:9292/faye');
    faye.subscribe("/board", function(data){
        eval(data);
    });
});