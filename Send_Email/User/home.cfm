<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="../CSS//style2.css">
                <script type="text/javascript" src="email.js"></script>
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
        <body>
                <cftry>  
                        <cflogin> 
                                <cfloginuser
                                        name = "#session.newUser#"
                                        password ="Surya@123"
                                        roles = "admin"> 
                        </cflogin> 
                        <div class="container">
                                <div class="jumbotron vertical-center">             
                                
                                        <div class="col-md-8 bg-light inbox" >
                                
                                                        <cflock timeout=20 scope="Session" type="Exclusive">
                                                                <p><cfoutput>Logged in as: #getAuthUser()#</cfoutput></p>
                                                        </cflock>
                                                        <p>Nothing here! Wasted your time...</p>
                                                
                                                <div class="col-xs-12" >
                                                        <cfform>
                                                                <cfinput name="TEST" type="submit" class="btn btn-primary col-md-2" value="Logout">
                                                        </cfform>
                                                </div>
                                        </div>
                                </div>
                        </div>
                               
                        <cfif isDefined("form.test")> 
                                <cflogout> 
                                <cfset StructClear(Session)>
                                <cfcookie name="user" expires="now">
                                <cfcookie name="email" expires="now">
                                <cfcookie name="password" expires="now"> 
                                <div id="spinner" class="d-flex justify-content-center animate__animated animate__fadeIn">
                                        <div class="spinner-border text-primary" role="status">
                                                <span class="sr-only">Loading...</span>
                                        </div>
                                </div>

                                <script>
                                        $('.spinner-border').fadeOut(4000);                                
                                </script>
                                <meta http-equiv = "refresh" content = "2;url = /index.cfm" />
                        </cfif>
                                
                        <cfcatch type="any">
                                
                                <div class="alert alert-danger alert-dismissible" role="alert">
                                        User Logged Out... Please login again! 
                                        <button type="button" class="close" data-dismiss="alert" (click)="alertClose()" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                        </button>
                                </div>
                                
                                <meta http-equiv = "refresh" content = "2;url = /index.cfm" />
                        </cfcatch>
                </cftry>  
                
        </body>
</html>
