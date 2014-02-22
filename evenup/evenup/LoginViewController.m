//
//  LoginViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseCell.h"

@interface LoginViewController () <UITableViewDelegate, UITableViewDataSource, SignUpViewControllerDelegate>
{
    UITableView *formTableView;
    UIButton *logInButton;
    UIButton *signUpButton;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Log In";
	// Do any additional setup after loading the view.
    formTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 75, self.view.frame.size.width-40, 140) style:UITableViewStyleGrouped];
    formTableView.backgroundColor = [UIColor clearColor];
    formTableView.dataSource = self;
    formTableView.delegate = self;
    formTableView.scrollEnabled = NO;
    [self.view addSubview:formTableView];
    
    logInButton = [[UIButton alloc] initWithFrame:CGRectMake(20, formTableView.frame.size.height+formTableView.frame.origin.y+30, self.view.frame.size.width-40, 20)];
    [logInButton setTitle:@"Log In" forState:UIControlStateNormal];
    [logInButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logInButton addTarget:self action:@selector(logUserIn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logInButton];
    
    signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-150, self.view.frame.size.width-40, 20)];
    [signUpButton setTitle:@"New User? Sign Up Here." forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(pushSignUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signUpButton];

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

-(void)pushSignUp
{
    self.signUpVc = [[SignUpViewController alloc] init];
    self.signUpVc.delegate = self;
    [self.navigationController pushViewController:self.signUpVc animated:YES];
}


- (void)SignUpViewController:(SignUpViewController *)viewController
               didSignUpUser:(BOOL)value
{
//    TODO -- App delegate not attaching to delegate properly. setting here
    [self.delegate LoginViewController:self didLogUserIn:YES];
}
#pragma mark -- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *formCell = [[BaseCell alloc] initAsCellTextField];
    NSString *textLabel = nil;
    NSString *textPlaceHolder = nil;
    switch (indexPath.row) {
        case 0:
            textLabel = @"Username";
            textPlaceHolder = @"Email or Number";
            break;
        case 1:
            textLabel = @"Password";
            textPlaceHolder = @"Enter Password";
        default:
            break;
    }
    formCell.selectionStyle = UITableViewCellSelectionStyleNone;
    formCell.textLabel.text = textLabel;
    formCell.textField.placeholder = textPlaceHolder;
    return formCell;
}

@end
