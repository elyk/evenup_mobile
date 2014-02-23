//
//  BaseViewController.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "Utils.h"
@interface BaseViewController : UIViewController
{
    
}

-(void)setLeftMenuButton;
-(void)showModalViewController:(BaseViewController *)viewController;
@end
