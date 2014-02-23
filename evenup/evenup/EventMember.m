//
//  EventMember.m
//  evenup
//
//  Created by Kyle Connors on 2/23/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "EventMember.h"

@implementation EventMember
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSLog(@"dicTION is %@", dictionary);
        
        self.number = [dictionary objectForKey:@"number"];
        self.name = [dictionary objectForKey:@"name"];
        if (dictionary[@"user"] != [NSNull null]) {
            self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        }
        
        self.event_member_purchased_items = [dictionary objectForKey:@"event_member_purchased_items"];
        
        self.purchased_items_count = [NSString stringWithFormat:@"%i", self.event_member_purchased_items.count];



    }
    
    return self;
}
@end
