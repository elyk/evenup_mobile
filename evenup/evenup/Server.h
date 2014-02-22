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

#define BASE_URL @"http://www.baseurl.com"



@interface Server : NSObject
{
    
}

+(Server *)sharedServer;
-(void) requestOfType:(int)request_type forUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod;
@end
