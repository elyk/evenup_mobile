//
//  PaymentViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "PaymentViewController.h"
#import "STPView.h"
@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Payment Details";
    
    [self setLeftMenuButton];
    
    STPView *stripeView = [[STPView alloc] initWithFrame:CGRectMake(20, 50, self.view.frame.size.width-40, 300) andKey:@"pk_test_rYhRKdREwHaMp6KoaveWVNsE"];
    
    [self.view addSubview:stripeView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
