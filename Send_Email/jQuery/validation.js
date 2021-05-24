/*  File: validation.js
    Description: Contains js for registration page. Has Validation and AJAX call to CFC file.
    Date: ‎May ‎7, ‎2021. 
*/

function validateData()
{
        var checkUser,checkPassword1,checkPassword2,checkEmail, call1, call2;
        checkUser = isUsernameValid();
        checkPassword1 = isPassword1Valid();
        checkPassword2 = isPassword2Valid();
        checkEmail = isEmailValid();
        call1 = checkUser && checkPassword1 && checkPassword2 && checkEmail;
        call2 = ajaxcall();
        return call1 && call2;
}

function ajaxcall(){
        var user, email, password1,password2, checke = true, checkp1 = true, checku = true, checkp2 = true;
        user = $("#user").val();
        email = $("#email").val();
        password1 = $("#passwordl").val();
        password2 = $("#passwordc").val();

        $.ajax({
        type: 'POST',
        url: '/CFC/validation.cfc?method=validation',
        dataType: "json",
        data: { arg1: email, arg2: password1, arg3: password2, arg4:user },
        cache:false,
        async:false,
        success: function(data) 
        {       
                if(data.user == 0)
                {
                        $("#umessage").text("Please enter a username");
                        checku = false;
                }
                else{
                        $("#umessage").text("");
                }
                if(data.email == 0)
                {
                        $("#emessage").text("Please enter an email address");
                        checke = false;
                }
                else if(data.email == 1)
                {
                        $("#emessage").text("Please enter a valid email address");
                        checke = false;
                }
                else if(data.email == 3)
                {
                        $("#emessage").text("User with same email address already exists!");
                        checke = false;
                }
                else{
                        $("#emessage").text("");
                }
                if(data.password1 == 0)
                {
                        $("#p1message").text("Please enter a password");
                        checkp1 = false;
                }
                else if(data.password1 == 1)
                {
                        $("#p1message").text("Please enter a valid password");
                        checkp1 = false;
                }
                else{
                        $("#p1message").text("");
                }
                if(data.password2 == 0)
                {
                        $("#p2message").text("Please enter Confirm password");
                        checkp2 = false;
                }
                else if(data.password2 == 1)
                {
                        $("#p2message").text("Passwords are not matching!");
                        checkp2 = false;
                }
                else{
                        $("#p2message").text("");
                }
        },
        error: function(){
                console.log("Problem while checking the fields");
                checku = false;
                }
        });
        return (checku && checke && checkp1 && checkp2);

}

function isEmailValid()
{
        var email;
        email = $("#email").val();
        if(email == "")
        {
                $("#emessage").text("Please enter an email address");
                return false;
        }
        else
        {
                email = email.toLowerCase();
                if(!(email.match(/^[a-z0-9_]+@[a-z]+[.]{1}[a-z]{2,3}$/)))
                {
                        $("#emessage").text("Please enter a valid email address");
                        return false;
                }
                else{
                        $("#emessage").text("");
                        return true;
                }
        }
}

function isPassword1Valid()
{
        var password1;
        password1 = $("#passwordl").val();   
        password2 = $("#passwordc").val();    
        if(password1 == "")
        {
                $("#p1message").text("Please enter password");
                return false;
        }
        else
        {
                if(password1.length<8 || password1.search(/[A-Z]/) == -1 || password1.search(/[a-z]/) == -1 || password1.search(/[0-9]/) == -1)
                {
                        $("#p1message").text("Password should contain a lower case letter, an upper case letter, a digit and atleast 8 character");
                        return false;
                }
                else
                {
                        if(password2 != "")
                        {
                                if(password1 != password2)
                                {
                                        $("#p2message").text("Passwords are not matching!");
                                        $("#passwordc").val("");
                                        return false;
                                }
                                else
                                {
                                        $("#p2message").text("");
                                }
                        }
                        $("#p1message").text("");
                        return true;
                }
        }
}

function isPassword2Valid()
{
        var password1, password2;
        password1 = $("#passwordl").val();
        password2 = $("#passwordc").val();
        if(password2 == "")
        {
                $("#p2message").text("Please enter a confirm password");
                return false;
        }
        else
        {
                if(password1 != password2)
                {
                        $("#p2message").text("Passwords are not matching!");
                        $("#passwordc").val("");
                        return false;
                }
                else
                {
                        $("#p2message").text("");
                        return true;
                }
        }

        
}

function isUsernameValid()
{
        var user;
        user = $("#user").val();
        if(user == "")
        {
                $("#umessage").text("Please enter a username");
                return false;
        }
        else{
                $("#umessage").text("");
                return true;
        }
}