window.onload = function() {
	listener("selectall","click",function(){
		checkboxSelectAll("selectall","gid") ;
	}) ;
	listener("deleteBtn","click",function(){
		handleDelete("gid",jsDeleteUrl) ;
	}) ;
} 