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
        NSLog(@"dict is %@", dictionary);
        self.eventDate = dictionary[@"event_date"];
        self.amountOwed = dictionary[@"amount_owed"];
        self.status = dictionary[@"status"];

        self.title = dictionary[@"title"];
        self.event_id = [NSString stringWithFormat:@"%i", [dictionary[@"id"] intValue]];
        self.is_active = [dictionary[@"is_active"] boolValue];
        self.description = dictionary[@"description"];
        self.created_date = dictionary[@"created"];
        self.event_members = dictionary[@"event_members"];
        
        self.membersCount = [NSString stringWithFormat:@"%i", self.event_members.count];
        
        self.eventDate = @"Sunday";
        
        if (self.is_active) {
            self.status = @"OPEN";
        } else {
            self.status = @"CLOSED";
        }
        
    }
    
    return self;
}



@end


