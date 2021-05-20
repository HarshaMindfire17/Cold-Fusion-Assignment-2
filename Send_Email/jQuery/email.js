/*  File: email.js
    Description: Contains js for home page. Has Validation and AJAX call to CFC file.
    Date: ‎May ‎14, ‎2021. 
*/

function submitForm()
{
        var call1,call2;
        call1=isEmailValid();
        call2=canSend();
        call=call1 && call2;
        return call;
}

function isEmailValid()
{
        var email = $('#email').val();
        if(email == "")
        {
                $("#emessage").text("Please enter an email address");
                return false;
        }
        else
        {
                $("#emessage").text("");  
                email = email.toLowerCase();
                email = email.replace(/\s+/g, '');
                var i;
                email = email.split(",");
                for(i = 0;i < email.length;i++)
                {
                        if(!(email[i].match(/^[a-z0-9_]+@[a-z]+[.]{1}[a-z]{2,3}$/)))
                        {
                                $("#emessage").text("Please check the email ids entered!");
                                return false;
                        }
                        else{
                                $("#emessage").text("");
                                return true;
                        }
                }
        }
}

function canSend(){
        var checke = true;
        var email = $('#email').val();
        email = email.replace(/\s+/g, '');
        var message = $('#message').val();
        var subject = $('#subject').val();

        $.ajax({
        type: 'POST',
        url: '/CFC/mailit.cfc?method=validation',
        dataType: "json",
        async:false,
        cache:false,
        data: { arg1: email, arg2:subject, arg3: message},
        success: function(data) 
        {
                if(data.email == 0)
                {
                        $("#emessage").text("Please enter an email address");
                        checke = false;
                }
                else if(data.email == 1)
                {
                        $("#emessage").text("Please check the email ids entered!");
                        checke = false;
                }
                else if(data.email == 2)
                {
                        $("#emessage").text("Mail not sent! Please check your connectivity!");
                        checke = false;
                }
                else if(data.email == 3){
                        $("#emessage").text("Session Timed out. Please login again!");
                        checke = false;
                }
                else{
                        $("#emessage").text("");
                }
        },
        error:function(){
                console.log("Error while reading data!");
                checke=false;
        }
        });
        return checke;
}