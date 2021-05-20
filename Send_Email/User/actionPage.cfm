/*  File: actionPage.cfm
    Description: ActionPage for registration and login forms. Redirects user to home page.
    Date: May‎ 6, ‎2021. 
*/
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body class="background3">
                <div class="container">
                        <cfif URL.check == 1>
                                <!--- Write your code here --->
                                <cflocation url = "./home.cfm" addToken = "no" statusCode = "302">
                        <cfelseif URL.check == 0>           
                                <!--- Write your code here --->
                                <cflocation url = "./home.cfm" addToken = "no" statusCode = "302">
                                                                                                                             
                        </cfif>     
                </div>
        </body>
</html>
