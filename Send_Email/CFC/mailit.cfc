<!---   File: mailit.cfc
        Description: Contains function for validation of email addresses and sends a mail.
        Date: ‎May ‎13, ‎2021.
--->

<cfcomponent hint = "Has functions for validation of email ids and sending the mail.">
        <!---   Name:        validation
                Description: Validation of email addresses entered: 
                             Check if they are valid. If yes, send an email to those addresses.
                Arguments:   email addresses, subject and body of the mail.
                Returns:     JSON object
        --->

        <cffunction name = "validation" access = "remote" returntype = "any" returnformat = "JSON"
        hint = "Validates email ids entered and sends mails to the receipients" output = "false">

                <cfargument name = "arg1" type = "any" default = "" hint = "mail ids">
                <cfargument name = "arg2" type = "any" default = "" hint = "subject of mail">
                <cfargument name = "arg3" type = "any" default = "" hint = "body of mail">
                <cfset emailFlag = 0>

                <cfif ARGUMENTS.arg1 neq "">

                        <!--- Check the email addresses are valid --->
                        <cfset myList = "#ARGUMENTS.arg1#">
                        <cfloop list = "#myList#" delimiters = "," index = "each_mail">
                                <cfif NOT isValid("regex","#each_mail#","^[a-z0-9_]+@[a-z]+[.]{1}[a-z]{2,3}$")>
                                        <cfset emailFlag = 1>
                                        <cfbreak>
                                </cfif>
                        </cfloop>
                        
                        <!--- Send a mail if all the addresses are valid --->
                        <cfif emailFlag neq 1>
                                <cftry>
                                        <cfmail
                                                from = "#SESSION.newEmail#"
                                                to = "#ARGUMENTS.arg1#"
                                                spoolenable="false"
                                                subject = "#ARGUMENTS.arg2#">
                                                #ARGUMENTS.arg3#
                                        </cfmail> 
                                        <cfset emailFlag = 4>
                                        <cfcatch>
                                                <cfif SESSION.newEmail eq "">
                                                        <cflog type = "warning" file = "logger" text = "Mail not sent due to Session Timeout!">
                                                        <cfset emailFlag = 3>
                                                <cfelse>
                                                        <cflog type = "warning" file = "logger" text = "Mail not sent due to connectivity issues!">
                                                        <cfset emailFlag = 2>
                                                </cfif>
                                                
                                        </cfcatch> 
                                </cftry> 
                        </cfif> 
                </cfif>
                <cfset var returnValue = '{"email":"#emailFlag#"}'> 
                <cfreturn returnValue>
        </cffunction>
</cfcomponent>
