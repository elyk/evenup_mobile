//
//  Server.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "Server.h"

@implementation Server

+(Server *)sharedServer
{
    static Server *server = nil;
    if (!server) {
        server = [[Server alloc] init];
        
//        server.tripCode = [[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_CODE_DEFAULT];
    }
    return server;
}
//
//-(void) getRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod
//{
//    NSString *URL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
//    
//    if (self.tripCode) {
//        if (!params) {
//            params = [[NSMutableDictionary alloc] init];
//        }
//        [params setObject:self.tripCode forKey:@"trip_code"];
//    }
//    
//    DLOG(@"GET REQUEST: %@ %@", URL, params);
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [target performSelectorInBackground:SuccessMethod withObject:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [target performSelectorInBackground:errorMethod withObject:error];
//    }];
//}


@end
