<!---File: validation.cfc
     Description: Contains functions for validation and authentication of users during login and registration.
     Date: ‎May ‎12, ‎2021.
--->
<cfcomponent hint = "Has functions for validation and authentication of users during login and registration.">
        <!---   Name:        validation
                Description: Validation during user registration: 
                             Validates email, passwords and add them to database 
                Arguments:   email, password, confirm password, username
                Returns:     JSON object
        --->

        <cffunction name = "validation" access = "remote" returntype = "any" returnformat = "JSON" 
        hint = "Validates user during registration process and adds them to database" output = "false">

                <cfargument name = "arg1" type = "string" default = "" hint = "email id">
                <cfargument name = "arg2" type = "string" default = "" hint = "password">
                <cfargument name = "arg3" type = "string" default = "" hint = "confirm password">
                <cfargument name = "arg4" type = "string" default = "" hint = "username">

                <!--- If email field is not empty, check if it is valid or not --->
                <cfif ARGUMENTS.arg1 eq "">
                        <cfset emailFlag = 0>
                        <cfelseif isValid("regex", ARGUMENTS.arg1,"^[a-z0-9_]+@[a-z]+[.]{1}[a-z]{2,3}$")>
                                <cfset emailFlag = 2>
                        <cfelse>
                                <cfset emailFlag = 1>
                </cfif>

                <!--- If password field is not empty, check if it is valid or not --->
                <cfif ARGUMENTS.arg2 eq "">
                        <cfset passwordFlag = 0>
                        <cfelseif (len(arg2) LT 8|| reFind("[A-Z]+",ARGUMENTS.arg2) eq 0 || reFind("[a-z]+",ARGUMENTS.arg2) eq 0 || reFind("[0-9]+",ARGUMENTS.arg2) eq 0)>
                                <cfset passwordFlag = 1> 
                        <cfelse>
                                <cfset passwordFlag = 2>
                </cfif>

                <!--- If confirm password field is not empty, check if it is valid or not --->
                <cfif ARGUMENTS.arg3 eq "">
                        <cfset confirmationFlag = 0>
                        <cfelseif (arg2 neq ARGUMENTS.arg3)>
                                <cfset confirmationFlag = 1> 
                        <cfelse>
                                <cfset confirmationFlag = 2>
                </cfif>

                <!--- Check if username is empty --->
                <cfif ARGUMENTS.arg4 eq "">
                        <cfset userFlag = 0>
                        <cfelse>
                                <cfset userFlag = 1>
                </cfif>

                <!--- If all the above fields are valid, insert them into database --->
                <cfif (emailFlag eq 2 && passwordFlag eq 2 && confirmationFlag eq 2 && userFlag eq 1)>
                        <cfquery datasource = "Receivers">
                                INSERT INTO Users(sender,email,password) VALUES('#ARGUMENTS.arg4#','#ARGUMENTS.arg1#', '#ARGUMENTS.arg2#');
                        </cfquery>
                        <cfset SESSION.newEmail = "#ARGUMENTS.arg1#">
                        <cfset SESSION.newUser = "#ARGUMENTS.arg4#">  
                        <cflogin> 
                                <cfloginuser
                                        name  =  "#ARGUMENTS.arg4#"
                                        password  = "#ARGUMENTS.arg2#"
                                        roles  =  "admin"> 
                        </cflogin> 
                </cfif>

                <cfset var returnValue = '{"email":"#emailFlag#","password1":"#passwordFlag#","password2":"#confirmationFlag#","user":"#u#"}'> 
                <cfreturn returnValue>

        </cffunction>

        <!---   Name:        authentication
                Description: Authentication during user login: 
                             Validates email and password and checks if the user is present in database.
                Arguments:   email, password
                Returns:     JSON object
        --->

        <cffunction name = "authentication" access = "remote" returntype = "any" returnformat = "JSON" 
        hint = "Validates user during login process and then performs authentication" output = "false">

                <cfargument name = "arg1" type = "string" default = "" hint = "email id">
                <cfargument name = "arg2" type = "string" default = "" hint = "password">

                <!--- If email field is not empty, check if it is valid or not 
                        If yes, check if user exists in database.
                --->     
                <cfif ARGUMENTS.arg1 eq "">
                        <cfset emailFlag = 0>
                        <cfelseif NOT isValid("regex", ARGUMENTS.arg1,"^[a-z0-9_]+@[a-z]+[.]{1}[a-z]{2,3}$")>
                                <cfset emailFlag = 1>
                        <cfelse>
                                <cfquery datasource = "Receivers" name = "rsPage1" cachedwithin = "#CreateTimespan(0,0,30,0)#">
                                        SELECT COUNT(*) AS isValid FROM Users WHERE email = <CFQUERYPARAM VALUE = #ARGUMENTS.arg1#>;
                                </cfquery>                                
                                <cfif rsPage1.isValid eq 0>
                                        <cfset emailFlag = 2>
                                        <cfelse>                                       
                                                <cfset emailFlag = 3>
                                </cfif>
                </cfif>

                <!--- If password field is not empty, check if it is valid or not.
                        If yes, check if the password matches with the user's from the database.
                --->
                <cfif ARGUMENTS.arg2 eq "">
                        <cfset passwordFlag = 0>

                        <!--- Check if password has a lowercase and uppercase, atleast 8 characters and a digit --->
                        <cfelseif (len(arg2) LT 8|| reFind("[A-Z]+", ARGUMENTS.arg2) eq 0 || reFind("[a-z]+", ARGUMENTS.arg2) eq 0 || reFind("[0-9]+", ARGUMENTS.arg2) eq 0)>
                                <cfset passwordFlag = 1> 

                        <cfelseif emailFlag eq 3>

                                        <!--- if user exists in database, check whether the password matches or not --->
                                        <cfset SESSION.newEmail = "#ARGUMENTS.arg1#">
                                        <cfquery datasource = "Receivers" name = "rsPage2" maxrows = 1 cachedwithin = "#CreateTimespan(0,0,30,0)#">
                                                SELECT sender FROM Users WHERE email = <CFQUERYPARAM VALUE = #ARGUMENTS.arg1#> AND password = <CFQUERYPARAM VALUE = #ARGUMENTS.arg2#>;
                                        </cfquery>
                                        <cfif rsPage2.sender neq "">
                                                <cfset SESSION.newUser = "#rsPage2.sender#">  
                                                <cfset passwordFlag = 3>

                                                <!--- the password matches, login the user and create cookies --->
                                                <cflogin> 
                                                        <cfloginuser
                                                                name = "#SESSION.newUser#"
                                                                password ="#ARGUMENTS.arg2#"
                                                                roles = "admin"> 
                                                </cflogin>
                                                <cfcookie name = "user" value = "#SESSION.newUser#" httpOnly = true encodevalue = "no" expires = "2">
                                                <cfcookie name = "email" value = "#ARGUMENTS.arg1#" httpOnly = true encodevalue = "no" expires = "2">
                                                <cfcookie name = "password" value = "#ARGUMENTS.arg2#" httpOnly = true encodevalue = "no" expires = "2">
                                                <cfelse> 
                                                        <cfset passwordFlag = 2>
                                        </cfif>  

                        <cfelse>
                                <cfset passwordFlag = 3>
                </cfif>

                <cfset var returnValue = '{"email":"#emailFlag#","password":"#passwordFlag#"}'> 
                <cfreturn returnValue>
        </cffunction>
</cfcomponent>

