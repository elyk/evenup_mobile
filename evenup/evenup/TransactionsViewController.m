//
//  TransactionsViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "TransactionsViewController.h"

@interface TransactionsViewController ()

@end

@implementation TransactionsViewController

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
    self.title = @"Transactions";
    [self setLeftMenuButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
