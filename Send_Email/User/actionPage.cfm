<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="../CSS//style.css">
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
                <script>
                        window.setTimeout(function() {
                                $(".alert").fadeTo(500, 0).slideUp(500, function(){
                                        $(this).remove(); 
                                });
                                }, 2000);
                </script>
        </head>
        
        
        <body class="background3">
                <div class="container">
                        <cfif URL.check==1>
                                
                                <cfquery datasource="Receivers" name="rsPage1" >
                                        INSERT into Users(sender,email,password) Values('#Form.user#','#Form.email#', '#Form.passwordl#');
                                </cfquery>

                                <div class="alert alert-success alert-dismissible" role="alert">
                                        Data Entered Successfully!
                                        <button type="button" class="close" data-dismiss="alert" (click)="alertClose()" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                        </button>
                                </div>

                                <cfset session.newEmail="#Form.email#">
                                <cfset session.newUser="#Form.user#">          
                                <script>
                                        setTimeout(function(){ location.href="home.cfm" }, 3000);
                                </script>

                        <cfelseif URL.check==0>
                                
                                <cfquery datasource="Receivers" name="rsPage1" >
                                        SELECT COUNT(*) as isValid from Users Where email='#Form.email#';
                                </cfquery>
                                
                                <cfif rsPage1.isValid!=0>
                                        <cfquery datasource="Receivers" name="rsPage2" >
                                                SELECT COUNT(*) as isUser from Users Where email='#Form.email#' and  password='#Form.passwordl#';
                                        </cfquery>
                                        
                                        <cfif rsPage2.isUser>
                                                <cfset session.newEmail="#Form.email#">
                                                <cfquery datasource="Receivers" name="rsPage2" >
                                                        SELECT sender from Users Where email='#Form.email#' and  password='#Form.passwordl#';
                                                </cfquery>
                                                <cfset session.newUser="#rsPage2.sender#"> 
                                                   
                                                <div class="alert alert-success alert-dismissible" role="alert">
                                                        Logging in as <cfdump var="#session.newUser#">!
                                                        <button type="button" class="close" data-dismiss="alert" (click)="alertClose()" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                        </button>
                                                </div>
                                                <cfcookie name="user" value="#session.newUser#" httpOnly=true encodevalue="no">
                                                <cfcookie name="email" value="#Form.email#" httpOnly=true encodevalue="no">
                                                <cfcookie name="password" value="#Form.passwordl#" httpOnly=true encodevalue="no">     
                                                        
                                                <script>
                                                        setTimeout(function(){ location.href="home.cfm" }, 3000);
                                                </script>
                                        <cfelse>
                                                <div class="alert alert-warning alert-dismissible" role="alert">
                                                        Please enter correct password! User Authentication failed!
                                                        <button type="button" class="close" data-dismiss="alert" (click)="alertClose()" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                        </button>
                                                </div>
                                                <script>
                                                        setTimeout(function(){ location.href="/index.cfm" }, 3000);
                                                </script>
                                        </cfif>
                                <cfelse>
                                        <script>
                                                setTimeout(function(){ location.href="/index.cfm" }, 3000);
                                        </script>
                                        <div class="alert alert-danger alert-dismissible" role="alert">
                                                Please create an account! User Authentication failed
                                                <button type="button" class="close" data-dismiss="alert" (click)="alertClose()" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                </button>
                                        </div>
                                </cfif>                                                                                                             
                        </cfif>     
                </div>
        </body>
</html>
