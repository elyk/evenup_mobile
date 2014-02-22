//
//  Event.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "Event.h"

@implementation Event


-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.membersCount = dictionary[@"members_count"];
        self.eventDate = dictionary[@"event_date"];
        self.amountOwed = dictionary[@"amount_owed"];
        self.status = dictionary[@"status"];
    }
    
    return self;
}

@end
