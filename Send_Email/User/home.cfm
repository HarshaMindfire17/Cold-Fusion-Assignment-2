<!--- File: home.cfm
    Description: Has interface for sending an email.
    Date: ‎May ‎6, ‎2021. 
 --->
<!--- after clicking submit button , check if session is terminated, session.newName--->
<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="../CSS/style2.css">
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        </head>
        <body>
                <cfinclude template="header2.cfm">
                
                        <cfif isDefined("form.test")> 
                                <cflogout> 
                                <cfset sessionInvalidate()>

                                <cfcookie name="user" expires="now">
                                <cfcookie name="email" expires="now">
                                <cfcookie name="password" expires="now"> 
                                <meta http-equiv = "refresh" content = "0;url = /index.cfm" />
                                <!--- <div id="spinner" class="d-flex justify-content-center animate__animated animate__fadeIn">
                                        <div class="spinner-border text-primary" role="status">
                                                <span class="sr-only">Loading...</span>
                                        </div>
                                </div>
        
                                <script>
                                        $('.spinner-border').fadeOut(2500);                                
                                </script> --->
                        
                        </cfif>
                <cftry>
                        <div class="container">
                                <div class="second">    
                                        <cfif #session.newUser# neq "">         
                                                <cflock timeout=20 scope="Session" type="Exclusive">
                                                        <p><cfoutput>Logged in as: #session.newUser# </cfoutput></p>
                                                        <!--- <p><cfoutput>Logged in as: #getAuthUser()#</cfoutput></p> --->
                                                </cflock>
                                                
                                                <div class="col-md-8 bg-light inbox" >
                                                        <div  id="target">
                                                                <form name="myform" id="myform" onsubmit="return submitForm()">
                                                                        <div class="row col-md-12">
                                                                                <div class="col-md-4">
                                                                                        <label for="email">Receipients</label>
                                                                                </div>
                                                                                <div class="col-md-8" >
                                                                                        <input type="text" name="email" id="email" placeholder="someone@example.com" autofocus="on" onblur="isEmailValid()">
                                                                                        <p id="emessage" class="red"></p>
                                                                                </div> 
                                                                        </div>
                                                                        <div class="row col-md-12">
                                                                                <div class="col-md-4">
                                                                                        <label for="subject">Subject</label>
                                                                                </div>
                                                                                <div class="col-md-8" >
                                                                                        <input type="text" name="subject" id="subject">                                                                
                                                                                </div>
                                                                        </div>
                                                                        <div class="row col-md-12">
                                                                                <div class="col-md-8" >
                                                                                        <textarea name="message" id="message" cols="80" rows="5" wrap="soft" required="yes" validate="noblanks" ></textarea>
                                                                                </div>
                                                                        </div>
                                                                        <button type="submit" id="submit" class="btn btn-primary col-md-2 offset-md-9 " name="submit">Send</button>                
                                                                </form>
                                                        
                                                        </div>
                                                
                                                        <div class="col-xs-6" >
                                                                <cfform>
                                                                        <cfinput name="TEST" type="submit" class="btn btn-primary col-md-2" value="Logout">
                                                                </cfform>
                                                        </div>

                                                </div>
                                        <cfelse>
                                                <cflog type="warning" file="logger" application="no" text="session timed out">
                                                <cfthrow type="Application">
                                        </cfif> 
                                </div>
                        </div>
                               
                        <cfcatch type="any">
                                <div class="alert alert-danger alert-dismissible" role="alert">
                                        Session Terminated. Please login again!
                                        <button type="button" class="close" data-dismiss="alert" onclick="alertClose()" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                        </button>
                                </div>
                                
                                <meta http-equiv = "refresh" content = "3;url = /index.cfm" />
                        </cfcatch>
                </cftry>  
                <cfinclude template="footer.cfm">
                <script type="text/javascript" src="/jQuery//email.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        </body>
</html>
