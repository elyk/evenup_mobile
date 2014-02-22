//
//  LoginViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseCell.h"

@interface LoginViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *formTableView;
    UIButton *logInButton;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    formTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 150) style:UITableViewStyleGrouped];
    formTableView.backgroundColor = [UIColor clearColor];
    formTableView.dataSource = self;
    formTableView.delegate = self;
    formTableView.scrollEnabled = NO;
    [self.view addSubview:formTableView];
    
    logInButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 20)];
    [logInButton setTitle:@"Log In" forState:UIControlStateNormal];
    [logInButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logInButton addTarget:self action:@selector(logUserIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logInButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logUserIn
{

    [self.delegate LoginViewController:self didLogUserIn:YES];
}

#pragma mark -- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *formCell = [[BaseCell alloc] initAsCellTextFieldWithPlaceholder:@"Username"];
    formCell.selectionStyle = UITableViewCellSelectionStyleNone;
    formCell.textLabel.text = @"Label";
    return formCell;
}

@end
