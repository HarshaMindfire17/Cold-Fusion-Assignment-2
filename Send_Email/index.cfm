<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">  
<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="CSS//style.css">
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
                
        </head>
        
        <body class="background1">
                <div class="container">                        
                        <div class="inbox" >
                                <div class="text-center" >
                                        Enter Login Details 
                                </div>
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
                                        <cfcatch>
                                                Hi
                                        </cfcatch>
                                </cftry> 
                                <div class="second col-xs-10">
                                        <cfform name="myform" onsubmit="return authenticateUser()" action="User/actionPage.cfm?check=0"><!---method="post" action="index.cfm"--->
                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="email">Email</label>
                                                        </div>
                                                        <div class="col-md-8" >
                                                                <cfinput
                                                                type="email"
                                                                name="email"
                                                                value="#cookiemail#"
                                                                id="email"
                                                                placeholder="someone@example.com">
                                                        </div>
                                                </div>
                                                
                                                
                                                 
                                                <div class="row col-md-12">
                                                        <div class="col-md-4">
                                                                <label for="passwordl">Password</label>
                                                        </div>
                                                        <div class="col-md-8" >
                                                                <cfinput
                                                                type="password"
                                                                id="passwordl"
                                                                value="#cookiepass#"
                                                                name="passwordl">
                                                        </div> 
                                                </div>
                                             
                                                <cfinput type="submit" class="btn btn-success col-md-2 offset-md-9" name="submit" >
                                                
                                        </cfform>
                                        
                                        <div style="padding:10px;">Don't have an account? <a href="User/register.cfm" style="color:blue;">Create One</a></div>
                                </div>
                        </div>
                
                </div>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                <script type="text/javascript" src="jQuery/authentication.js"></script>          
                
        </body>
</html>