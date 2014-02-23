//
//  EventViewController.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "BaseViewController.h"
#import "AddItemView.h"
#import "Event.h"
@interface EventViewController : BaseViewController
{
    
}
@property (nonatomic, strong) AddItemView *addItemView;
-(id)initWithEvent:(Event *)event;
@end
