//
//  BaseViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [Utils Color3];
    

    
}

-(void)setLeftMenuButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-25.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftNav:)];
}

-(void)toggleLeftNav:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showModalViewController:(BaseViewController *)viewController
{
    BaseNavigationController *baseNavVc = [[BaseNavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:baseNavVc animated:YES completion:nil];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeCurrentView)];
    
    
}

-(void)removeCurrentView
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
