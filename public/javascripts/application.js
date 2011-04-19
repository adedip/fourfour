$(function(){
    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe("/board", function(data){
        alert(data);
    });
});