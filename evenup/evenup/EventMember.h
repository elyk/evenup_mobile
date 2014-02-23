//
//  EventMember.h
//  evenup
//
//  Created by Kyle Connors on 2/23/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface EventMember : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSMutableArray *event_member_purchased_items;
@property (nonatomic, strong) NSString *purchased_items_count;
@property (nonatomic, strong) User *user;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
