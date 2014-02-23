//
//  Server.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET_REQUEST 1
#define POST_REQUEST 2
#define PATCH_REQUEST 3
#define PUT_REQUEST 4
#define DELETE_REQUEST 5

//#define BASE_URL @"http://obscure-brushlands-4385.herokuapp.com/"
#define BASE_URL @"http://10.60.20.234:8080/"
//#define BASE_URL @"http://127.0.0.1:8000/"

//LOGIN / SIGNUP 

#define SIGN_UP_URL @"signup/"
#define AUTH_TOKEN_URL @"api-token-auth/"

#define STRIPE_URL_PATH @"accounts/stripe/"

//EVENTS
#define EVENTS_URL @"events/"
#define EVENT_DETAILS_URL @"events/%@/"
#define EVENT_BILL_ITEMS_URL @"events/%@/billitems/"
#define EVENT_BILL_MEMBERS_URL @"events/%@/eventmembers/"
#define EVENT_BILL_SPLITTERS_URL @"events/%@/billitems/%@/billsplits/"
#define EVENT_BILL_SPLITTERS_DELETE_URL @"events/%@/billitems/%@/billsplits/delete"
@interface Server : NSObject
{
    
}

+(Server *)sharedServer;
+(NSArray *)getAllContacts;
@property(nonatomic, strong) NSString *authToken;
-(void)removeAuthTok;
-(void)LoadAuthToken;
-(void)setTheAuthToken:(NSString *)authToken;
-(void) requestOfType:(int)request_type forUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod;

-(void) authLoginRequest:(int)request_type forUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod;
@end
