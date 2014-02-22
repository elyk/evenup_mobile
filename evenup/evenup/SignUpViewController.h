//
//  SignUpViewController.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "BaseViewController.h"

@protocol SignUpViewControllerDelegate;

@interface SignUpViewController : BaseViewController
{
    
}
@property (nonatomic, weak) id<SignUpViewControllerDelegate> delegate;


@end
// 3. Definition of the delegate's interface
@protocol SignUpViewControllerDelegate <NSObject>

- (void)SignUpViewController:(SignUpViewController *)viewController
               didSignUpUser:(BOOL)value;

@end