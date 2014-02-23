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

    
    BaseCell *firstNameCell;
    BaseCell *lastNameCell;
    BaseCell *emailCell;
    BaseCell *phoneCell;
    BaseCell *passWordCell;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sign Up";
    self.navigationController.navigationBarHidden = NO;
	// Do any additional setup after loading the view.
    
    firstNameCell = [[BaseCell alloc] initAsCellTextField];
    lastNameCell = [[BaseCell alloc] initAsCellTextField];
    emailCell = [[BaseCell alloc] initAsCellTextField];
    phoneCell = [[BaseCell alloc] initAsCellTextField];
    passWordCell = [[BaseCell alloc] initAsCellTextField];
    
    
    formTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, 260) style:UITableViewStyleGrouped];
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

//    [self.delegate SignUpViewController:self didSignUpUser:YES];
    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] init];
    [paramsDict setObject:firstNameCell.textField.text forKey:@"first_name"];
    [paramsDict setObject:lastNameCell.textField.text forKey:@"last_name"];
    [paramsDict setObject:phoneCell.textField.text forKey:@"phone"];
    [paramsDict setObject:emailCell.textField.text forKey:@"email"];
    [paramsDict setObject:passWordCell.textField.text forKey:@"password"];
    
    [[Server sharedServer] requestOfType:POST_REQUEST forUrl:SIGN_UP_URL params:paramsDict target:self successMethod:@selector(signUserUpSuccessResponse:) errorMethod:@selector(signUserUpErrorResponse:)];
}

-(void)signUserUpSuccessResponse:(NSObject *)response
{
    NSLog(@"success response is %@", response);
}

-(void)signUserUpErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);
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
            formCell = firstNameCell;
            break;
        case 1:
            textLabel = @"Last Name";
            textPlaceHolder = @"";
            formCell = lastNameCell;
            break;
        case 2:
            textLabel = @"Email";
            formCell = emailCell;
            break;
        case 3:
            textLabel = @"Phone";
            formCell = phoneCell;
            break;
        case 4:
            textLabel = @"Password";
            formCell = passWordCell;
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