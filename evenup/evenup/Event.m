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
        
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        
        //The Z at the end of your string represents Zulu which is UTC
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat:@"YYYY-MM-DD'T'HH:mm:ss'Z'"];
        NSLog(@"creatd date %@", self.created_date);
        NSString* newTime = [dateFormatter stringFromDate:self.created_date];
        NSLog(@"new time %@", newTime);
        
        //Add the following line to display the time in the local time zone
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormatter setDateFormat:@"M/d/yy 'at' h:mma"];
        self.eventDate = newTime;
        
        
        if (self.is_active) {
            self.status = @"OPEN";
        } else {
            self.status = @"CLOSED";
        }
        
    }
    
    return self;
}

@end


