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
        self.title = dictionary[@"description"];
        self.event_members = dictionary[@"event_members"];
        self.bill_splits = dictionary[@"bill_item_splits"];
        self.event_payer = dictionary[@"purchaser"];
        self.event_price = [NSString stringWithFormat:@"%i", [dictionary[@"cost"] intValue]];
        self.did_pay = [dictionary[@"did_pay"] boolValue];
        
        
        NSMutableString *membersString = [[NSMutableString alloc] init];
        for (NSMutableDictionary *dict in self.bill_splits) {
            NSString *name = dict[@"owner"];
            NSString *stringW = [NSString stringWithFormat:@"%@ ", name];
            [membersString appendString:stringW];
            
            
        }
        
        self.bill_splitters = [NSString stringWithString:membersString];
    }
    
    return self;
}



@end
