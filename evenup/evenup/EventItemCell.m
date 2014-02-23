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
    
    UILabel *checkBoxLabel;
}

@end

@implementation EventItemCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        checkBoxLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-20, 0, 20, 20)];
        checkBoxLabel.backgroundColor = [UIColor colorWithRed:16/255.0f green:111/255.0f blue:0/255.0f alpha:1.0f];
        checkBoxLabel.layer.cornerRadius = 10;
        checkBoxLabel.textColor = [UIColor whiteColor];
        checkBoxLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        checkBoxLabel.text = @"\u2713";
        [self.contentView addSubview:checkBoxLabel];
        [checkBoxLabel setHidden:YES];
        
        itemTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width/2, 30)];
        itemTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        itemTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:itemTitleLabel];
        
        eventMembersLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, self.frame.size.width/2, 10)];
        eventMembersLabel.backgroundColor = [UIColor clearColor];
        eventMembersLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        eventMembersLabel.textAlignment = NSTextAlignmentCenter;
        eventMembersLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:eventMembersLabel];
        
        
        
        
//        UILabel *amountOwed = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 40, 40, 10)];
//        amountOwed.font = [UIFont boldSystemFontOfSize:8.0f];
//        amountOwed.textColor = [UIColor lightGrayColor];
//        amountOwed.textAlignment = NSTextAlignmentRight;
//        amountOwed.text = @"Owe";
//        [self.contentView addSubview:amountOwed];
        
        eventOwnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-(self.frame.size.width/4), 20, self.frame.size.width/4, 10)];
        eventOwnerLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        eventOwnerLabel.textAlignment = NSTextAlignmentCenter;
        eventOwnerLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:eventOwnerLabel];
        
        
//        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 60, 40, 10)];
//        status.font = [UIFont boldSystemFontOfSize:8.0f];
//        status.textColor = [UIColor lightGrayColor];
//        status.textAlignment = NSTextAlignmentRight;
//        status.text = @"Status";
//        [self.contentView addSubview:status];
        
        eventPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-(self.frame.size.width/4), 45, self.frame.size.width/4, 10)];
        eventPriceLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        eventPriceLabel.textAlignment = NSTextAlignmentCenter;
        eventPriceLabel.textColor = [UIColor colorWithRed:77/255.0f green:138/255.0f blue:0/255.0f alpha:1.0f];
        [self.contentView addSubview:eventPriceLabel];
        
        
        
        
    }
    return self;
}

-(void)setItem:(EventItem *)eventItem
{
    itemTitleLabel.text = @"Item Name";
//    eventItem.title;
    eventMembersLabel.text = [NSString stringWithFormat:@"John, Bill, Mary"];
    eventOwnerLabel.text = [NSString stringWithFormat:@"%@ PAID", @"JOHN"];
//    eventItem.event_payer
    eventPriceLabel.text = @"$35";
//    eventItem.event_price;
}

-(void)setAsSplit
{
    self.contentView.backgroundColor =[UIColor colorWithRed:16/255.0f green:181/255.0f blue:0/255.0f alpha:.1f];
    [checkBoxLabel setHidden:NO];
}

-(void)removeSetAsSplit
{
    self.contentView.backgroundColor = [UIColor clearColor];
    [checkBoxLabel setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
