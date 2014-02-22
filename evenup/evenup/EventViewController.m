//
//  EventViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *eventTable;
    UISegmentedControl *toggleSegment;
    
    NSArray *eventItemsArray;
    NSArray *eventMembersArray;
}
@end

@implementation EventViewController

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
    
    toggleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Items", @"Members"]];
    toggleSegment.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
//    toggleSegment.backgroundColor = [UIColor greenColor];
    [self.view addSubview:toggleSegment];
    
    eventTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    eventTable.dataSource = self;
    eventTable.delegate = self;
    
    [self.view addSubview:eventTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
            cellText = @"Event Name";
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
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}



@end
