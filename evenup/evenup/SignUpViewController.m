//
//  SignUpViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "SignUpViewController.h"
#import "BaseCell.h"
@interface SignUpViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *formTableView;
    UIButton *SignUpButton;

}
@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sign Up";
    self.navigationController.navigationBarHidden = NO;
	// Do any additional setup after loading the view.
    formTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width-40, 260) style:UITableViewStyleGrouped];
    formTableView.backgroundColor = [UIColor clearColor];
    formTableView.dataSource = self;
    formTableView.delegate = self;
    formTableView.scrollEnabled = NO;
    [self.view addSubview:formTableView];
    
    SignUpButton = [[UIButton alloc] initWithFrame:CGRectMake(20, formTableView.frame.size.height+formTableView.frame.origin.y+10, self.view.frame.size.width-40, 20)];
    [SignUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [SignUpButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [SignUpButton addTarget:self action:@selector(signUserUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:SignUpButton];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)signUserUp
{
    NSLog(@"got here!");
    [self.delegate SignUpViewController:self didSignUpUser:YES];
}

#pragma mark -- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *formCell = [[BaseCell alloc] initAsCellTextField];
    NSString *textLabel = nil;
    NSString *textPlaceHolder = nil;
    switch (indexPath.row) {
        case 0:
            textLabel = @"First Name";
            textPlaceHolder = @"";
            break;
        case 1:
            textLabel = @"Last Name";
            textPlaceHolder = @"";
            break;
        case 2:
            textLabel = @"Email";
            textPlaceHolder = @"Email Address";
            break;
        case 3:
            textLabel = @"Phone";
            textPlaceHolder = @"Mobile #";
            break;
        case 4:
            textLabel = @"Password";
            textPlaceHolder = @"";
            formCell.textField.secureTextEntry = YES;
            break;
        default:
            break;
    }
    formCell.selectionStyle = UITableViewCellSelectionStyleNone;
    formCell.textLabel.text = textLabel;
    formCell.textField.placeholder = textPlaceHolder;
    return formCell;
}
@end