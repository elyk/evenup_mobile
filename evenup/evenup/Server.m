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
    
//    TODO -- do a check here for user params
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (request_type==GET_REQUEST) {
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


@end
