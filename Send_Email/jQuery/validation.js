function validateData()
{
	var check1, check2;
        if($("#user").val()=="")
        {
                var txt = $('<p>Please enter username!</p>');
                $("#user").after(txt);
                txt.addClass("red");
        }
        else{
                sessionStorage.setItem("check",true);
                $(".red").remove();
                
        }
        
        check1=$("#email").val();
        if(check1=="")
        {
                var txt = $('<p>Please enter an email address</p>');
                $("#email").after(txt);
                txt.addClass("red");
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
                }
                else{
                        $(".red").remove();
                }
        }

        check2=$("#passwordl").val();
        if(check2=="")
        {
                var txt = $('<p>Please enter a password</p>');
                $("#passwordl").after(txt);
                txt.addClass("red");
                return false;
        }
        else
        {
                $(".red").remove();
                if(check2.length<8 || check2.search(/[A-Z]/)==-1 || check2.search(/[a-z]/)==-1 || check2.search(/[0-9]/)==-1)
                {
                        var txt = $('<p>Password should contain a lower case letter, an upper case letter, a digit and atleast 8 characters</p>');
                        $("#passwordl").after(txt);
                        txt.addClass("red");
                        return false;
                }
                else
                {
                        $(".red").remove();
                }
        }

        if($("#passwordc").val()=="")
        {
                var txt = $('<p>Please enter a confirm password</p>');
                $("#passwordc").after(txt);
                txt.addClass("red");
                return false;
        }
        else
        {
                $(".red").remove();
        }

        if($("#passwordc").val()!=$("#passwordl").val())
        {
                var txt = $('<p>Passwords are not matching!</p>');
                $("#passwordc").val("");
                $("#passwordc").after(txt);
                txt.addClass("red");
                return false;
        }
        else
        {
                $(".red").remove();
        }
        return true;
}