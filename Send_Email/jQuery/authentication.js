function authenticateUser()
{
	var check1, check2,check=true;
       
        check1=$("#email").val();
        if(check1=="")
        {       
                if($(".red").val()==undefined)
                {
                        var txt = $('<p>Please enter an email address</p>');
                        $("#email").after(txt);
                        txt.addClass("red");
                }
                check= false;
        }
        else
        {
                $(".red").remove();
                check1=check1.toLowerCase();
                if(!(check1.match(/^[a-z0-9_]+@[a-z]+[.]{1}[a-z]{2,3}$/)))
                {
                        var txt = $('<p>Please enter a valid email address</p>');
                        $("#email").after(txt);
                        txt.addClass("red");
                        check= false;
                }
                else{
                        $(".red").remove();
                }
        }
        
        check2=$("#passwordl").val();
        if(check2=="")
        {
                if($(".red").val()==undefined)
                {
                        var txt = $('<p>Please enter a password</p>');
                        $("#passwordl").after(txt);
                        txt.addClass("red");    
                }
                check= false;
        }
        else
        {
                $(".red").remove();
                if(check2.length<8 || check2.search(/[A-Z]/)==-1 || check2.search(/[a-z]/)==-1 || check2.search(/[0-9]/)==-1)
                {
                        var txt = $('<p>Invalid password!</p>');
                        $("#passwordl").after(txt);
                        txt.addClass("red");
                        check=false;
                }
                else
                {
                        $(".red").remove();
                }
        }
        
        return check;
}
