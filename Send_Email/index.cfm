<!---   File: index.cfm
        Description: Has interface for user login.
        Date: ‎May ‎6, ‎2021. 
 --->

<!DOCTYPE HTML>  
<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="CSS/style.css">
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        </head>
        
        <body class="background1">
                <cfinclude template = "User/header.cfm">
                <div class="container">                        
                        <div class="inbox" >
                                <div class="text-center" >
                                        Enter Login Details 
                                </div>
                                
                                <div class="second col-xs-10">                                          
                                        <form name="myform" onsubmit="return authenticateUser()" action="User/actionPage.cfm" method="post"> 
                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="email">Email</label>
                                                        </div>
                                                        
                                                        <div class="col-md-8" >
                                                                <input
                                                                type="email"
                                                                name="email"
                                                                id="email"
                                                                onblur="isEmailValid()"
                                                                placeholder="someone@example.com">
                                                                <p id="emessage" class="red"></p>

                                                        </div>
                                                </div>
                                                
                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="passwordl">Password</label>
                                                        </div>
                                                        <div class="col-md-8" >
                                                                <input
                                                                type="password"
                                                                id="passwordl"
                                                                onblur="isPasswordValid()"
                                                                name="passwordl">
                                                                <p id="pmessage" class="red"></p>
                                                        </div> 
                                                </div>
                                                <div class="row col-md-8 offset-md-4">
                                                        <cftry>
                                                                <cfset cookiemail="">
                                                                <cfset cookiepass="">
                                                                <cfset cookies = getPageContext().getRequest().getCookies()>
                                                                <cfloop index="c" array="#cookies#">            
                                                                        <cfif ToString(c.getName()) EQ "EMAIL">
                                                                                <cfset cookiemail=c.getValue()>
                                                                        </cfif>
                                                                        <cfif ToString(c.getName()) EQ "PASSWORD">
                                                                                <cfset cookiepass=c.getValue()>
                                                                        </cfif>
                                                                </cfloop>  
                                                                
                                                                <cfif cookiemail eq "">
                                                                        <cfthrow type="No cookies enabled">
                                                                <cfelse>
                                                                        <input
                                                                        type="checkbox"
                                                                        id="forget"
                                                                        name="forget">
                                                                        <label for="forget" id="forgetid">Forget me</label>
                                                                </cfif> 
                                                                <cfcatch>
                                                                        
                                                                        <input
                                                                        type="checkbox"
                                                                        id="remember"
                                                                        checked
                                                                        name="remember">
                                                                        <label for="remember" id="remid">Remember me</label>   
                                                
                                                                </cfcatch>
                                                        </cftry> 
                                                </div>
                                                <button type="submit" id="submit" class="btn btn-success col-md-2 offset-md-9" name="submit" >Submit</button>   
                                        </form> 
                                        
                                        <p>Don't have an account? <a href="User/register.cfm" style="color:blue;">Create One</a></p>
                                </div>
                        </div>
                </div>
                <cfinclude template="User/footer.cfm">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                <script type="text/javascript" src="jQuery//authentication.js"></script>    
                <script type="text/javascript" >
                        <cfoutput>
                                var #toScript(cookiemail, "jsmail")#;
                                var #toScript(cookiepass, "jspass")#;
                        </cfoutput>
                        $("#email").val(jsmail);
                        $("#passwordl").val(jspass);
                </script>
        </body>
</html>
