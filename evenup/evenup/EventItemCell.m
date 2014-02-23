//
//  EventDetailsCell.m
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "EventItemCell.h"

@interface EventItemCell()
{
    UILabel *itemTitleLabel;
    UILabel *eventMembersLabel;
    UILabel *eventOwnerLabel;
    UILabel *eventPriceLabel;
}

@end

@implementation EventItemCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width/2, 30)];
        itemTitleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        itemTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:itemTitleLabel];
        
        
        
        UILabel *membersLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 20, 40, 10)];
        membersLabel.font = [UIFont boldSystemFontOfSize:8.0f];
        membersLabel.textColor = [UIColor lightGrayColor];
        membersLabel.text = @"Members";
        [self.contentView addSubview:membersLabel];
        
        eventMembersLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 20, self.frame.size.width/2-30, 10)];
        eventMembersLabel.backgroundColor = [UIColor clearColor];
        eventMembersLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        eventMembersLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:eventMembersLabel];
        
        
        
        
        UILabel *amountOwed = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 40, 40, 10)];
        amountOwed.font = [UIFont boldSystemFontOfSize:8.0f];
        amountOwed.textColor = [UIColor lightGrayColor];
        amountOwed.textAlignment = NSTextAlignmentRight;
        amountOwed.text = @"Owe";
        [self.contentView addSubview:amountOwed];
        
        eventOwnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 40, self.frame.size.width/2-30, 10)];
        eventOwnerLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        eventOwnerLabel.textAlignment = NSTextAlignmentRight;
        eventOwnerLabel.textColor = [UIColor colorWithRed:77/255.0f green:138/255.0f blue:0/255.0f alpha:1.0f];
        [self.contentView addSubview:eventOwnerLabel];
        
        
        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 60, 40, 10)];
        status.font = [UIFont boldSystemFontOfSize:8.0f];
        status.textColor = [UIColor lightGrayColor];
        status.textAlignment = NSTextAlignmentRight;
        status.text = @"Status";
        [self.contentView addSubview:status];
        
        eventPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 60, self.frame.size.width/2-30, 10)];
        eventPriceLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        eventPriceLabel.textAlignment = NSTextAlignmentRight;
        eventPriceLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:eventPriceLabel];
        
        
        
        
    }
    return self;
}

-(void)setItem:(EventItem *)eventItem
{
    itemTitleLabel.text = eventItem.title;
    eventMembersLabel.text = [NSString stringWithFormat:@"John, Bill, Mary"];
//    eventItem.event_members;
    eventOwnerLabel.text = [NSString stringWithFormat:@"$%@", eventItem.event_payer];
    eventPriceLabel.text = eventItem.event_price;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
