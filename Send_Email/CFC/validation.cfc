<!---File: validation.cfc
     Description: Contains functions for validation of users during registration.
     Date: ‎May ‎12, ‎2021.
--->
<cfcomponent hint = "Has function for validation of users during registration.">

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

                <cfset var returnValue = '{"email":"#emailFlag#","password1":"#passwordFlag#","password2":"#confirmationFlag#","user":"#userFlag#"}'> 
                <cfreturn returnValue>
        </cffunction>
</cfcomponent>

