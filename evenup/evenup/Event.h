//
//  Event.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *membersCount;
@property (nonatomic, strong) NSString *eventDate;
@property (nonatomic, strong) NSString *amountOwed;
@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *event_id;
@property BOOL is_active;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *created_date;
@property (nonatomic, strong) NSMutableArray *event_members;

-(id)initWithDictionary:(NSDictionary *)dictionary;
@end
