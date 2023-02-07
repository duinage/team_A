* you need to insert your filepath instead /home/u63099550/ex.xlsx to use this code
proc import datafile='/home/u63099550/ex.xlsx'
	out = myex_v1
	dbms=xlsx
	replace;
run;

proc sort data=myex_v1;
	by event_name;
run;

data myex_v1_sort_event_name;
	set myex_v1;
	by event_name;
	if first.event_name;
	keep event_name;
run;


data final;
	set myex_v1(keep = userid user_state event_name event_attributes event_created_date event_platform device_manufacture device_model);
	length AccountHistoryTransactionDetails	
	Account_Setup_Profile_Skip	
	Account_Setup_Skip	
	Add_Payment_Method_Failed	
	Add_Payment_Method_Success	
	Add_Vehicle_Break	
	Add_Vehicle_Failed	
	Add_Vehicle_Success	
	Calculator_Used	
	Calculator_View	
	Chat_Conversation_Opened	
	Chat_Conversation_Started	
	Email_Confirmation_Success	
	Order	
	Reset_Password_Set	
	Sign_Out	
	Sign_Up_Error	
	Sign_Up_Success	
	Subscription_Premium	
	Subscription_Premium_Cancel	
	Subscription_Premium_Renew	
	Transaction_Refund	
	Wallet_Opened $100;
	
	AccountHistoryTransactionDetails = "N"; 	
	Account_Setup_Profile_Skip = "N";
	Account_Setup_Skip	= "N";
	Add_Payment_Method_Failed = "N";
	Add_Payment_Method_Success	= "N";
	Add_Vehicle_Break = "N";
	Add_Vehicle_Failed	= "N";
	Add_Vehicle_Success	= "N";
	Calculator_Used	= "N";
	Calculator_View	= "N";
	Chat_Conversation_Opened = "N";	
	Chat_Conversation_Started	= "N";
	Email_Confirmation_Success	= "N";
	Order	= "N";
	Reset_Password_Set = "N";	
	Sign_Out	= "N";
	Sign_Up_Error	= "N";
	Sign_Up_Success	= "N";
	Subscription_Premium	= "N";
	Subscription_Premium_Cancel	= "N";
	Subscription_Premium_Renew	= "N";
	Transaction_Refund	= "N";
	Wallet_Opened = "N";
	
	if event_name = "Account History Transaction Details" then AccountHistoryTransactionDetails = event_attributes;
	else if event_name = "Account Setup Profile Skip" then Account_Setup_Profile_Skip = event_attributes;
	else if event_name = "Account Setup Skip" then Account_Setup_Skip = event_attributes;
	else if event_name = "Add Payment Method Failed" then Add_Payment_Method_Failed = event_attributes;
	else if event_name = "Add Payment Method Success" then Add_Payment_Method_Success = event_attributes;
	else if event_name = "Add Vehicle Break" then Add_Vehicle_Break = event_attributes;
	else if event_name = "Add Vehicle Failed" then Add_Vehicle_Failed = event_attributes;
	else if event_name = "Add Vehicle Success" then Add_Vehicle_Success = event_attributes;
	else if event_name = "Calculator Used" then Calculator_Used = event_attributes;
	else if event_name = "Calculator View" then Calculator_View = event_attributes;
	else if event_name = "Chat Conversation Opened" then Chat_Conversation_Opened = event_attributes;
	else if event_name = "Chat Conversation Started" then Chat_Conversation_Started = event_attributes;
	else if event_name = "Email Confirmation Success" then Email_Confirmation_Success = event_attributes;
	else if event_name = "Order" then Order = event_attributes;
	else if event_name = "Reset Password_Set" then Reset_Password_Set = event_attributes;
	else if event_name = "Sign_Out" then Sign_Out = event_attributes;
	else if event_name = "Sign Up Error" then Sign_Up_Error = event_attributes;
	else if event_name = "Sign Up Success" then Sign_Up_Success = event_attributes;
	else if event_name = "Subscription Premium" then Subscription_Premium = event_attributes;
	else if event_name = "Subscription Premium Cancel" then Subscription_Premium_Cancel = event_attributes;
	else if event_name = "Subscription Premium Renew" then Subscription_Premium_Renew = event_attributes;
	else if event_name = "Transaction Refund" then Transaction_Refund = event_attributes;
	else if event_name = "Wallet Opened" then Wallet_Opened = event_attributes;
run;

proc sort data = final out = final_sorted;
	by userid;
run;

proc export data = final_sorted
	outfile="/home/u63099550/final_sorted_export.xlsx"
	dbms = xlsx
	replace;
	sheet="All data";
run;