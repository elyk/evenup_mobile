//
//  AddItemView.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventItem.h"
@protocol AddItemViewDelegate;




@interface AddItemView : UIView
{
    
}
@property (nonatomic, weak) id<AddItemViewDelegate> delegate;

@property (nonatomic, strong) UITableView *formTable;
@property BOOL is_displayed;
-(void)adjustFrame:(CGRect)frame;
@property (nonatomic, strong) NSString *eventId;
@end

@protocol AddItemViewDelegate <NSObject>

-(void)AddItemView:(AddItemView *) view didAddItem:(EventItem *)item;
@end