//
//  EventItem.h
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *item_id;
@property (nonatomic, strong) NSMutableArray *event_members;
@property (nonatomic, strong) NSMutableArray *bill_splits;
@property (nonatomic, strong) NSString *event_payer;
@property (nonatomic, strong) NSString *event_price;
@property (nonatomic, strong) NSString *bill_splitters;
@property BOOL did_pay;
@property BOOL is_splitting;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end

    