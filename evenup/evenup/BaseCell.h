//
//  BaseCell.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell
{
    
}

@property(nonatomic, strong)UITextField *textField;
-(id)initAsCellTextFieldWithPlaceholder:(NSString *)placeholder;
@end
