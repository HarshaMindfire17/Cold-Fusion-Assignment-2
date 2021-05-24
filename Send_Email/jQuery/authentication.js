/*  File: authentication.js
    Description: Contains js for login page. Has Validation and AJAX call to CFC file.
    Date: ‎May ‎7, ‎2021. 
*/

function authenticateUser()
{
        //Client side validation
	var email, password,checke = true, checkp = true;
        checke = isEmailValid();
        checkp=isPasswordValid();
        var call1 = checke && checkp;
        var call2 = ajaxcall();
        return (call1 && call2);
}

function ajaxcall()
{
        var email, password, remember = true,forget = false, checke = true, checkp = true;
        email = $("#email").val();
        password = $("#passwordl").val();
        if($('#remember').length)
        {
                remember = $("#remember").is(":checked");
        }
        else if($('#forget').length){
                forget = $("#forget").is(":checked");}
        
        $.ajax({
        type: 'POST',
        url: 'CFC/authentication.cfc?method=authentication',
        dataType: "json",
        data: { arg1 : email, arg2 : password, arg3 : remember, arg4 : forget},
        cache:false,
        async:false,
        success: function(data) 
        {       
                if(data.email == 0)
                {
                        $("#emessage").text("Please enter a email address");
                        checke = false;
                }
                else if(data.email == 1)
                {
                        $("#emessage").text("Please enter an valid email address");
                        checke = false;
                }
                else if(data.email == 2)
                {
                        $("#emessage").text("Email not registered!");
                        checke = false;
                }
                else{
                        $("#emessage").text("");
                }
        
                if(data.password == 0)
                {
                        $("#pmessage").text("Please enter a password");
                        checkp = false;
                }
                else if(data.password == 1)
                {
                        $("#pmessage").text("Password should contain a lower case letter, an upper case letter, a digit and atleast 8 characters");
                        checkp = false;
                }
                else if(data.password == 2)
                {
                        $("#pmessage").text("Email id or Password incorrect. Please verify!");
                        checkp = false;
                }
                
                else{$("#pmessage").text("");}
        },
        error: function(){
                console.log("Problem while checking the fields");
                checke = false;
                }
        });
        return (checke && checkp);
}

function isEmailValid()
{
        var email,checke = true;
        email = $("#email").val();
        if(email=="")
        {       
                $("#emessage").text("Please enter an email address");
                checke = false;
        }
        else
        {
                email = email.toLowerCase();
                if(!(email.match(/^[a-z0-9_]+@[a-z]+[.]{1}[a-z]{2,3}$/)))
                { 
                        $("#emessage").text("Please enter valid email address");
                        checke = false;
                }
                else{
                        $("#emessage").text("");
                        checke = true;
                }
        }
        return checke;
}

function isPasswordValid(){

        var password, checkp=true;
        password = $("#passwordl").val();
        if(password == "")
        {
                $("#pmessage").text("Please enter a password");
                checkp = false;
        }
        else
        {
                if(password.length<8 || password.search(/[A-Z]/) == -1 || password.search(/[a-z]/) == -1 || password.search(/[0-9]/) == -1)
                {
                        $("#pmessage").text("Password should contain a lower case letter, an upper case letter, a digit and atleast 8 characters");
                        checkp = false;
                }
                else
                {
                        $("#pmessage").text("");
                        checkp = true;
                }
        }
        return checkp;
}