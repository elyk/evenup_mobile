//
//  HomeViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "HomeViewController.h"
#import "AddEventViewController.h"
#import "EventViewController.h"
#import "Event.h"
#import "MainEventCell.h"
@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *eventsTable;
    NSMutableArray *eventsArray;
    
    UILabel *amountOwedValueLabel;
    UILabel *amountDueValueLabel;
    
}
@end

@implementation HomeViewController

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
    self.title = @"EvenUP";

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewEvent)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftMenuButton];
    
    
    UILabel *amountOwedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width/2, 15)];
    amountOwedLabel.text = @"AMOUNT OWED";
    amountOwedLabel.textAlignment = NSTextAlignmentCenter;
    amountOwedLabel.textColor = [UIColor lightGrayColor];
    amountOwedLabel.font = [UIFont boldSystemFontOfSize:9.0f];
    [self.view addSubview:amountOwedLabel];
    
    
    UILabel *amountDueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 10, self.view.frame.size.width/2, 15)];
    amountDueLabel.text = @"AMOUNT DUE";
    amountDueLabel.textAlignment = NSTextAlignmentCenter;
    amountDueLabel.textColor = [UIColor lightGrayColor];
    amountDueLabel.font = [UIFont boldSystemFontOfSize:9.0f];
    [self.view addSubview:amountDueLabel];
    
    
    amountOwedValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width/2, 30)];
    amountOwedValueLabel.text = @"$0";
    amountOwedValueLabel.textColor = [UIColor colorWithRed:77/255.0f green:138/255.0f blue:0/255.0f alpha:1.0f];
    amountOwedValueLabel.font = [UIFont boldSystemFontOfSize:28.0f];
    amountOwedValueLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:amountOwedValueLabel];
    
    amountDueValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 50, self.view.frame.size.width/2, 30)];
    amountDueValueLabel.text = @"$0";
    amountDueValueLabel.textColor = [UIColor colorWithRed:214/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    amountDueValueLabel.font = [UIFont boldSystemFontOfSize:28.0f];
    amountDueValueLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:amountDueValueLabel];
    
    
    UILabel *openEventsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 20)];
    openEventsLabel.text = @"OPEN EVENTS";
    openEventsLabel.textAlignment = NSTextAlignmentCenter;
    openEventsLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    openEventsLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:openEventsLabel];
    
    UIView *lineViewLeft = [[UIView alloc] initWithFrame:CGRectMake(20, openEventsLabel.frame.size.height/2, 80, .5)];
    lineViewLeft.backgroundColor = [UIColor lightGrayColor];
    [openEventsLabel addSubview:lineViewLeft];

    UIView *lineViewRight = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-20-80, openEventsLabel.frame.size.height/2, 80, .5)];
    lineViewRight.backgroundColor = [UIColor lightGrayColor];
    [openEventsLabel addSubview:lineViewRight];
    
    
    
    eventsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStylePlain];
    eventsTable.delegate = self;
    eventsTable.dataSource = self;
    [self.view addSubview:eventsTable];
    
    [self loadEvents];
}


-(void)loadEvents
{
    
    NSDictionary *eventDict = [[NSDictionary alloc] initWithObjects:@[@"Tahoe Trip", @"12", @"Tuesday", @"20", @"OPEN"] forKeys:@[@"title", @"members_count", @"event_date", @"amount_owed", @"status"]];
    
    NSDictionary *eventDict2 = [[NSDictionary alloc] initWithObjects:@[@"Tipsy Pig's", @"4", @"Tuesday", @"12", @"CLOSED"] forKeys:@[@"title", @"members_count", @"event_date", @"amount_owed", @"status"]];
    
    
    Event *event1 = [[Event alloc] initWithDictionary:eventDict];
    Event *event2 = [[Event alloc] initWithDictionary:eventDict2];
    eventsArray = [NSMutableArray arrayWithArray:@[event1, event2]];
    [eventsTable reloadData];
}

-(void)createNewEvent
{
//    [self.navigationController presentViewController:[[AddEventViewController alloc] init] animated:YES completion:nil];
    
//    [self.navigationController pushViewController:[[AddEventViewController alloc] init] animated:YES];
    [self showModalViewController:[[AddEventViewController alloc] init]];
    
}

#pragma mark -- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eventsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MainEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    }
    
    Event *event = [eventsArray objectAtIndex:indexPath.row];
    [cell setEvent:event];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}


#pragma mark -- Tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    Event *event = [[Event alloc] initWithDictionary:<#(NSDictionary *)#>]
    EventViewController *eventVc = [[EventViewController alloc] init];
    [self.navigationController pushViewController:eventVc animated:YES];

}


@end
