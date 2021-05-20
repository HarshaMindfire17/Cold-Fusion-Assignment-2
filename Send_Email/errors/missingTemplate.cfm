<!--- File: missingTemplate.cfm
    Description: Displays a missing template page and then redirects
                 Put this in \CFIDE\administrator\templates and add the path in CFAdmin
    Date: ‎May ‎18, ‎2021. 
 --->
<html>
        <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link rel="stylesheet" href="../CSS/style3.css">
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        </head>
        <body>
                <div class="container-fluid">
                        <div class="header bg-dark">
                        </div>
                        <div class="bg-secondary inbox text-center">
                                <p>404</p>
                        </div>
                        <div class="text-center second" >
                                Missing a template here! Sorry!
                                <meta http-equiv = "refresh" content = "2;url = /index.cfm" />
                        </div>
                </div>
        </body>
</html>