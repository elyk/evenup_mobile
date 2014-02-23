//
//  EventDetailsCell.h
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSwipeTableViewCell.h"
#import "EventItem.h"
@interface EventItemCell : MCSwipeTableViewCell


-(void)setItem:(EventItem *)eventItem;
-(void)setAsSplit;
-(void)removeSetAsSplit;
@end
