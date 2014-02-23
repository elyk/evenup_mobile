//
//  SideViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#define HOME_CELL 0
#define PROFILE_CELL 1
#define PAYMENT_CELL 2
#define TRASACTIONS_CELL 3
#define NOTIFICATONS_CELL 4
#define PAST_EVENTS_CELL 5


#import "SideViewController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "PaymentViewController.h"
#import "TransactionsViewController.h"
#import "NotificationsViewController.h"
#import "PastEventsViewController.h"


@interface SideViewController () <UITableViewDelegate, UITableViewDataSource>

{
    UITableView *navTable;
    UILabel *nameLabel;
    
    UIButton *logOutButton;
}
@end

@implementation SideViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:1.0f];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, self.view.frame.size.width, 50)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [self.view addSubview:nameLabel];
    
    navTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    navTable.delegate = self;
    navTable.dataSource = self;
    navTable.backgroundColor = [UIColor clearColor];
    navTable.separatorColor = [UIColor colorWithRed:211/255.0f green:211/255.0f blue:211/255.0f alpha:1.0f];
    
    [self.view addSubview:navTable];
    
    [self setNameLabel:@"Kyle Connors"];
    
    
    logOutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
//    [logOutButton setBackgroundColor:[UIColor whiteColor]];
    logOutButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOutButton setTitle:@"LOG OUT" forState:UIControlStateNormal];
    [logOutButton addTarget:self action:@selector(logUserOut) forControlEvents:UIControlEventTouchUpInside];
    logOutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.view addSubview:logOutButton];
}

-(void)logUserOut
{
//    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USER_TOKEN_KEY];
    [[Server sharedServer] removeAuthTok];
    

    NSLog(@"log out");
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(bringUserToLogin)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- View's data setting methods

-(void)setNameLabel:(NSString *)name
{
    nameLabel.text = name;
}


#pragma mark -- tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSString *cellText = nil;
    
    switch (indexPath.row) {
        case 0:
            cellText = @"Home";
            break;
        case 1:
            cellText = @"Profile";
            break;
        case 2:
            cellText = @"Payment";
            break;
        case 3:
            cellText = @"Transactions";
            break;
        case 4:
            cellText = @"Notifications";
            break;
        case 5:
            cellText = @"Past Events";
            break;
        default:
            cellText = @"";
            break;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = cellText;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}


#pragma mark -- tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseViewController *pushedVc = nil;
    
    switch (indexPath.row) {
        case HOME_CELL:
            pushedVc = [[HomeViewController alloc] init];
            break;
        case PROFILE_CELL:
            pushedVc = [[ProfileViewController alloc] init];
            break;
        case PAYMENT_CELL:
            pushedVc = [[PaymentViewController alloc] init];
            break;
        case TRASACTIONS_CELL:
            pushedVc = [[TransactionsViewController alloc] init];
            break;
        case NOTIFICATONS_CELL:
            pushedVc = [[NotificationsViewController alloc] init];
            break;
        case PAST_EVENTS_CELL:
            pushedVc = [[PastEventsViewController alloc] init];
            break;
        default:
            break;
    }
    
    
    BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:pushedVc];
    
    
    self.viewDeckController.centerController = navController;
    [self.viewDeckController toggleLeftViewAnimated:YES];
    
}

@end
