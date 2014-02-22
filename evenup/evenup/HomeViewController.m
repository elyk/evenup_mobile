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
@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *eventsTable;
    NSMutableArray *eventsArray;
    
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(toggleLeftNav:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewEvent)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    eventsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 300) style:UITableViewStylePlain];
    eventsTable.delegate = self;
    eventsTable.dataSource = self;
    [self.view addSubview:eventsTable];
    
    [self loadEvents];
}


-(void)loadEvents
{
    eventsArray = [NSMutableArray arrayWithArray:@[@"Event 1", @"Event 2", @"Event 3", @"Event 4"]];
    [eventsTable reloadData];
}

-(void)createNewEvent
{
//    [self.navigationController presentViewController:[[AddEventViewController alloc] init] animated:YES completion:nil];
    
    [self.navigationController pushViewController:[[AddEventViewController alloc] init] animated:YES];
    
}

#pragma mark -- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eventsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
//    TODO -- model event and bring back
    NSString *eventTitle = [eventsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = eventTitle;
    return cell;
}

#pragma mark -- Tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Event *event = [[Event alloc] initWithDictionary:<#(NSDictionary *)#>]
    EventViewController *eventVc = [[EventViewController alloc] init];
    [self.navigationController pushViewController:eventVc animated:YES];

}

@end
