//
//  Server.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "Server.h"
#import "AFHTTPRequestOperationManager.h"
@implementation Server

+(Server *)sharedServer
{
    static Server *server = nil;
    if (!server) {
        server = [[Server alloc] init];
        
    }
    return server;
}

-(void) requestOfType:(int)request_type forUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSLog(@"auth token is %@", [self authToken]);
//    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:[self authToken]];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[self authToken] password:nil];
    
    
    //    incase isn't sent over'
    if (params == nil) {
        params = [[NSMutableDictionary alloc] init];
    }
    

    
    if (request_type==GET_REQUEST) {
        NSLog(@"request header is %@", manager.requestSerializer.HTTPRequestHeaders);
        [manager GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
    } else if (request_type==POST_REQUEST) {
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
        
    } else if (request_type==PATCH_REQUEST) {
        [manager PATCH:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
    } else if (request_type==PUT_REQUEST) {
        [manager PUT:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
        
        
    }

    
}

-(void) authLoginRequest:(int)request_type forUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    
    //    TODO -- do a check here for user params
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (request_type==POST_REQUEST) {
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
        
    }
}


-(void)setTheAuthToken:(NSString *)authToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:authToken forKey:USER_TOKEN_KEY];
    [defaults synchronize];
    self.authToken = authToken;
    
//    [[NSUserDefaults standardUserDefaults]
//     setObject:authToken forKey:USER_TOKEN_KEY];
}

-(void)LoadAuthToken
{
    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN_KEY];
}

-(void)removeAuthTok
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USER_TOKEN_KEY];
    [defaults synchronize];
    self.authToken = nil;
    
}




@end
