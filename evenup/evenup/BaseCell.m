//
//  BaseCell.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initAsCellTextField
{
    self = [super init];
    if (self) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width/2-10, 0, self.frame.size.width/2+10, self.frame.size.height)];
        [self.contentView addSubview:self.textField];
        self.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        self.textLabel.textColor = [UIColor lightGrayColor];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
