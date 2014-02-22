//
//  Server.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject
{
    
}

+(Server *)sharedServer;
//-(void) getRequestWithUrl:(NSString *)url params:(NSDictionary *)params target:(id)target successMethod:(SEL)successMethod errorMethod:(SEL)errorMethod;
@end
