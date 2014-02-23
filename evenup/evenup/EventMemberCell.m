//
//  EventMemberCell.m
//  evenup
//
//  Created by Kyle Connors on 2/23/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "EventMemberCell.h"
#import "User.h"
#import "Utils.h"
@implementation EventMemberCell
{
    UILabel *eventMemberTitle;
    UILabel *eventPurchasedCount;
    UILabel *eventSpentLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        checkBoxLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-20, 0, 20, 20)];
//        checkBoxLabel.backgroundColor = [UIColor colorWithRed:16/255.0f green:111/255.0f blue:0/255.0f alpha:1.0f];
//        checkBoxLabel.layer.cornerRadius = 10;
//        checkBoxLabel.textColor = [UIColor whiteColor];
//        checkBoxLabel.font = [UIFont boldSystemFontOfSize:18.0f];
//        checkBoxLabel.text = @"\u2713";
//        [self.contentView addSubview:checkBoxLabel];
//        [checkBoxLabel setHidden:YES];
        
        eventMemberTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width/2, 30)];
        eventMemberTitle.font = [UIFont boldSystemFontOfSize:20.0f];
        eventMemberTitle.textAlignment = NSTextAlignmentCenter;
        eventMemberTitle.textColor = [Utils Color3];
        [self.contentView addSubview:eventMemberTitle];
        
        
        UILabel *eventPurchasedLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 70, 10)];
        eventPurchasedLabel.font = [UIFont boldSystemFontOfSize:8.0f];
        eventPurchasedLabel.textColor = [UIColor lightGrayColor];
        eventPurchasedLabel.textAlignment = NSTextAlignmentLeft;
        eventPurchasedLabel.text = @"PURCHASED";
        [self.contentView addSubview:eventPurchasedLabel];

        UILabel *eventPurchasedLabelAfter = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 40, 10)];
        eventPurchasedLabelAfter.font = [UIFont boldSystemFontOfSize:8.0f];
        eventPurchasedLabelAfter.textColor = [UIColor lightGrayColor];
        eventPurchasedLabelAfter.textAlignment = NSTextAlignmentLeft;
        eventPurchasedLabelAfter.text = @"ITEMS";
        [self.contentView addSubview:eventPurchasedLabelAfter];
        
        
        
        eventPurchasedCount = [[UILabel alloc] initWithFrame:CGRectMake(75, 60, 20, 10)];
        eventPurchasedCount.backgroundColor = [UIColor clearColor];
        eventPurchasedCount.font = [UIFont boldSystemFontOfSize:8.0f];
        eventPurchasedCount.textAlignment = NSTextAlignmentCenter;
        eventPurchasedCount.textColor = [Utils Color5];
        [self.contentView addSubview:eventPurchasedCount];
        
        
        
        
        UILabel *totalSpentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-(self.frame.size.width/4), 20, 80, 10)];
        totalSpentLabel.font = [UIFont boldSystemFontOfSize:8.0f];
        totalSpentLabel.textColor = [UIColor lightGrayColor];
        totalSpentLabel.textAlignment = NSTextAlignmentCenter;
        totalSpentLabel.text = @"TOTAL SPENT";
        [self.contentView addSubview:totalSpentLabel];
        
        
        

        
        eventSpentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-(self.frame.size.width/4), 45, self.frame.size.width/4, 10)];
        eventSpentLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        eventSpentLabel.textAlignment = NSTextAlignmentCenter;
        eventSpentLabel.textColor = [Utils Color5];
        [self.contentView addSubview:eventSpentLabel];
        
        
        
        
    }
    return self;
}

-(void)setMember:(EventMember *)eventMember
{
    NSLog(@"event Member is %@", eventMember);
    if (eventMember.user != nil) {
    eventMemberTitle.text = [NSString stringWithFormat:@"%@ %@", eventMember.user.first_name, eventMember.user.last_name];
    } else {
        eventMemberTitle.text = eventMember.name;
    }

    //    eventItem.title;
    eventPurchasedCount.text = eventMember.purchased_items_count;
    //    eventItem.event_payer
    eventSpentLabel.text = @"$45.24";
    //    eventItem.event_price;
}
@end