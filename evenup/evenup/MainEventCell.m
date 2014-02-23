//
//  MainEventCell.m
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#define EVENT_STATUS_OPEN @"OPEN"
#define EVENT_STATUS_CLOSED @"CLOSED"

#import "MainEventCell.h"

@interface MainEventCell ()
{
    UILabel *eventTitleLabel;
    UILabel *eventMembersCountLabel;
    UILabel *eventDateLabel;
    UILabel *eventOwedLabel;
    UILabel *eventStatusLabel;
}

@end

@implementation MainEventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        eventTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width/2, 30)];
        eventTitleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        eventTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:eventTitleLabel];
        
        
        eventDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, self.frame.size.width/2, 25)];
        eventDateLabel.font = [UIFont systemFontOfSize:14.0f];
        eventDateLabel.textColor = [UIColor lightGrayColor];
        eventDateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:eventDateLabel];
        
        
        UILabel *membersLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 20, 40, 10)];
        membersLabel.font = [UIFont boldSystemFontOfSize:8.0f];
        membersLabel.textColor = [UIColor lightGrayColor];
        membersLabel.text = @"Members";
        [self.contentView addSubview:membersLabel];
        
        eventMembersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 20, self.frame.size.width/2-30, 10)];
        eventMembersCountLabel.backgroundColor = [UIColor clearColor];
        eventMembersCountLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        eventMembersCountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:eventMembersCountLabel];
        

        
        
        UILabel *amountOwed = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 40, 40, 10)];
        amountOwed.font = [UIFont boldSystemFontOfSize:8.0f];
        amountOwed.textColor = [UIColor lightGrayColor];
        amountOwed.textAlignment = NSTextAlignmentRight;
        amountOwed.text = @"Owe";
        [self.contentView addSubview:amountOwed];
        
        eventOwedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 40, self.frame.size.width/2-30, 10)];
        eventOwedLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        eventOwedLabel.textAlignment = NSTextAlignmentRight;
        eventOwedLabel.textColor = [UIColor colorWithRed:77/255.0f green:138/255.0f blue:0/255.0f alpha:1.0f];
        [self.contentView addSubview:eventOwedLabel];
        
        
        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+40, 60, 40, 10)];
        status.font = [UIFont boldSystemFontOfSize:8.0f];
        status.textColor = [UIColor lightGrayColor];
        status.textAlignment = NSTextAlignmentRight;
        status.text = @"Status";
        [self.contentView addSubview:status];
        
        eventStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 60, self.frame.size.width/2-30, 10)];
        eventStatusLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        eventStatusLabel.textAlignment = NSTextAlignmentRight;
        eventStatusLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:eventStatusLabel];
        
        
        
        
    }
    return self;
}

-(void)setEvent:(Event *)event
{
    eventTitleLabel.text = event.title;
    eventMembersCountLabel.text = event.membersCount;
    eventDateLabel.text = event.eventDate;
    eventOwedLabel.text = [NSString stringWithFormat:@"$%@", event.amountOwed];
    eventStatusLabel.text = event.status;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
