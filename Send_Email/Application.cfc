/*  File: Application.cfc
    Description: Has functions for specific events that occur during the lifetime of an application.
    Date: ‎May ‎6, ‎2021. 
 */
component 
{
     this.name="Send_Email";
     this.datasource="Receivers";
     this.sessionmanagement="Yes";
     this.ApplicationTimeout = CreateTimeSpan( 0, 0, 10,0);
     this.SessionTimeout = CreateTimeSpan( 0, 0, 0,10);
     this.mappings=structNew();

     function OnApplicationStart()
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created."
        {
        	WriteLog(type="Information", file="logger", text="Application Started");
		return true;
    	}


	function OnSessionStart()
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is first created."
        {
        	WriteLog(type="Information", file="logger", text="Session Started");
		return;
        }


	function OnRequestStart(required string Targetpage)
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires at first part of page processing."
        { 
        	WriteLog(type="Information", file="logger", application="no", text="OnRequestStart");
		return true;
    	}


	function OnRequest(required string TargetPage )
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete."
	{       
		include "#ARGUMENTS.TargetPage#";
		WriteLog(type="Information", file="logger", application="no", text="OnRequest"); 
		return;
	}


	function OnRequestEnd()
		access="public"
		returntype="void"
		output="true"
		hint="Fires after the page processing is complete."
        {
        	WriteLog(type="Information", file="logger", application="no", text="Request Ends here");
		return;
    	}


	function OnSessionEnd(struct ApplicationScope={}, required struct SessionScope)
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is terminated."
        {
        	WriteLog(type="Information", file="logger", application="no", text="Session Ended");
		return;
        }


	function OnApplicationEnd(struct ApplicationScope={})
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the application is terminated."
	{
        	WriteLog(type="Information", file="logger", application="no", text="Application Ended");
		return;
        }


	function OnError(string EventName="", required any Exception)
		access="public"
		returntype="void"
		output="true"
		hint="Fires when an exception occures that is not caught by a try/catch."
	{
		location("\errors\globalErrorHandler.cfm", "false", 301);
        	WriteLog(type="Error", file="logger", application="yes", text="#Exception#")
		return;
	}
	    
	function onMissingTemplate(required string template)
	    access="public"
	    returntype="boolean"
	    output="true"
	    hint="Fires when a non-existing CFM page is requested."
	{
		if (this.onRequestStart( arguments.template )){
			this.onRequest( arguments.template );
		}
		return true;
	}
}