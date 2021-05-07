component 
{
     this.name="Send_Email";
     this.datasource="Receivers";
     this.sessionmanagement="Yes";
     THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 10,0);
     THIS.SessionTimeout = CreateTimeSpan( 0, 0, 5,0);
     // this.setClientCookies=false;
}