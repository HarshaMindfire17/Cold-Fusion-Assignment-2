<!--- File: register.cfm
    Description: Has interface for user registration.
    Date: ‎May ‎6, ‎2021. 
 --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="../CSS/style.css">
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        </head>
        <body class="background2">
                <cfinclude template="header.cfm">

                <div class="container" >
                        <div class="inbox" >
                                <div class="text-center">
                                        Register
                                </div>
                                <div class="second col-xs-10">

                                        <form name="myform" onsubmit="return validateData()" action="actionPage.cfm?check=1" method="POST">
                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="user">Username</label>
                                                        </div>
                                                        <div class="col-md-8" >
                                                                <input type="text" name="user" id="user" onblur="isUsernameValid()"> 
                                                                <p id="umessage" class="red"></p>                                                               
                                                        </div>
                                                </div>

                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="email">Email</label>
                                                        </div>
                                                        <div class="col-md-8" >
                                                                <input type="email" name="email" id="email" placeholder="someone@example.com" onblur="isEmailValid()">
                                                                <p id="emessage" class="red"></p>
                                                        </div> 
                                                </div>

                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="passwordl">Password</label>
                                                        </div>
                                                        <div class="col-md-8" >
                                                                <input type="password" id="passwordl" name="passwordl" onblur="isPassword1Valid()">
                                                                <p id="p1message" class="red"></p>
                                                        </div>    
                                                </div>

                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="passwordc">Confirm Password</label>
                                                        </div>
                                                        <div class="col-md-8">
                                                                <input type="password" id="passwordc" name="passwordc" onblur="isPassword2Valid()">
                                                                <p id="p2message" class="red"></p>
                                                        </div>                   
                                                </div>
                                                <button type="submit" class="btn btn-success col-md-2 offset-md-9 " name="submit">Submit</button>
                                        </form>
                                </div>
                        </div>
                </div>
                <cfinclude template="footer.cfm">

                <script type="text/javascript" src="../jQuery/validation.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        </body>
</html>