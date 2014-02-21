//
//  SideViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "SideViewController.h"

@interface SideViewController () <UITableViewDelegate, UITableViewDataSource>

{
    UITableView *navTable;
    UILabel *nameLabel;
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
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, self.view.frame.size.width, 50)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [self.view addSubview:nameLabel];
    
    navTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    navTable.delegate = self;
    navTable.dataSource = self;
    navTable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:navTable];
    
    [self setNameLabel:@"Kyle Connors"];
    
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    NSString *cellText = nil;
    
    switch (indexPath.row) {
        case 0:
            cellText = @"Profile";
            break;
        case 1:
            cellText = @"Payment";
            break;
        case 2:
            cellText = @"Transactions";
            break;
        case 3:
            cellText = @"Notifications";
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


@end
