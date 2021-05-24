/*  File: actionPage.cfm
    Description: ActionPage for registration and login forms. Redirects user to home page.
    Date: May‎ 6, ‎2021. 
*/
<!DOCTYPE HTML>

<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body class="background3">
                <cflocation url = "./home.cfm" addToken = "no" statusCode = "302">
        </body>
</html>
