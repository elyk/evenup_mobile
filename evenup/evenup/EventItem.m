//
//  EventItem.m
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "EventItem.h"

@implementation EventItem

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.event_members = dictionary[@"event_members"];
        self.event_payer = dictionary[@"event_payer"];
        self.event_price = dictionary[@"event_price"];
        self.did_pay = [dictionary[@"did_pay"] boolValue];
    }
    
    return self;
}



@end
