//
//  LoginViewController.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginViewControllerDelegate;



@interface LoginViewController : BaseViewController
{
    
}
@property (nonatomic, weak) id<LoginViewControllerDelegate> delegate;
@end
// 3. Definition of the delegate's interface
@protocol LoginViewControllerDelegate <NSObject>

- (void)LoginViewController:(LoginViewController *)viewController
             didLogUserIn:(BOOL)value;

@end