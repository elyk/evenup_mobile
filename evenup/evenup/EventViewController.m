//
//  EventViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//
#define EVENT_TOGGLE_ITEMS 0
#define EVENT_TOGGLE_MEMBERS 1

#import "EventViewController.h"
#import "EventAdminViewController.h"
#import "EventItemViewController.h"
#import "EventMemberViewController.h"

@interface EventViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *eventTable;
    UISegmentedControl *toggleSegment;
    
    NSArray *eventItemsArray;
    NSArray *eventMembersArray;
    
    UIButton *addItem;
    UIButton *addMember;
    
    UIView *darkBGView;
    
    UITapGestureRecognizer *tapGesture;

}
@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Event Title";
    
//    TODO -- only an admin should see this
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(showAdminView)];
    toggleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Items", @"Members"]];
    toggleSegment.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 30);
    [toggleSegment addTarget:self action:@selector(didChangeSegmentValue:) forControlEvents:UIControlEventValueChanged];
    toggleSegment.selectedSegmentIndex = 0;

    [self.view addSubview:toggleSegment];
    
    addItem = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, self.view.frame.size.width-40, 30)];
    [addItem setTitle:@"Add Item +" forState:UIControlStateNormal];
    [addItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addItem addTarget:self action:@selector(addItemToEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addItem];
    
    addMember = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, self.view.frame.size.width-40, 30)];
    [addMember setTitle:@"Add Member +" forState:UIControlStateNormal];
    [addMember setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addMember addTarget:self action:@selector(addMemberToEvent) forControlEvents:UIControlEventTouchUpInside];
    [addMember setHidden:YES];
    [self.view addSubview:addMember];
    
    
    
    eventTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    eventTable.dataSource = self;
    eventTable.delegate = self;
    
    [self.view addSubview:eventTable];
    
    
    eventItemsArray = [NSArray arrayWithObjects:@"Item 1", @"Item 2", nil];
    eventMembersArray = [NSArray arrayWithObjects:@"Member 1", @"Member 2", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAdminView
{
    [self showModalViewController:[[EventAdminViewController alloc] init]];
}

-(void)didChangeSegmentValue:(UISegmentedControl *)sender
{
    NSLog(@"sender is %@", sender);
    if (sender.selectedSegmentIndex == EVENT_TOGGLE_ITEMS) {
        [self showItems];
    } else if (sender.selectedSegmentIndex == EVENT_TOGGLE_MEMBERS) {
        [self showMembers];
    }
}



-(void)showItems
{
    [addMember setHidden:YES];
    [addItem setHidden:NO];
    [eventTable reloadData];
}

-(void)showMembers
{
    [addItem setHidden:YES];
    [addMember setHidden:NO];
    [eventTable reloadData];
}

-(void)addItemToEvent
{
    self.addItemView = [[AddItemView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 350)];
    [self showAddView:self.addItemView];
    
}

-(void)showAddView:(AddItemView *)addView
{
    CGRect currentFrame = addView.frame;
    [self.view addSubview:addView];
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self addGrayBGView];
        [self.view bringSubviewToFront:addView];
        [addView adjustFrame:CGRectMake(currentFrame.origin.x, 10, currentFrame.size.width, currentFrame.size.height)];
    } completion:^(BOOL finished) {
        NSLog(@"animation complete");
        
        tapGesture = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(viewTouched)];
        
        [self.view addGestureRecognizer:tapGesture];
        
        
    }];
}

-(void)hideAndRemoveAddView:(AddItemView *)addView
{
    CGRect currentFrame = addView.frame;
    [self.view addSubview:addView];
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [addView adjustFrame:CGRectMake(currentFrame.origin.x, self.view.frame.size.height, currentFrame.size.width, currentFrame.size.height)];
        [self removeDarkBGView];
        
    } completion:^(BOOL finished) {
        NSLog(@"animation complete");
        [addView removeFromSuperview];
        self.addItemView = nil;
        [self.view removeGestureRecognizer:tapGesture];
        tapGesture = nil;
    }];
    
    
    
}

-(void)addMemberToEvent
{
    
}

-(void)addGrayBGView
{
    darkBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    darkBGView.backgroundColor = [UIColor blackColor];
    darkBGView.alpha = .7;
    [self.view addSubview:darkBGView];
}

-(void)removeDarkBGView
{
    [darkBGView removeFromSuperview];
    darkBGView = nil;
}

#pragma mark -- VIEW TOUCHED
-(void)viewTouched {
    [self.view resignFirstResponder];
    
    if (self.addItemView.is_displayed) {
        [self hideAndRemoveAddView:self.addItemView];
    }
}

#pragma mark -- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_ITEMS) {
        return eventItemsArray.count;
    } else if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_MEMBERS) {
        return eventMembersArray.count;
    } else {
        return 0;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSString *cellText = nil;
    
    if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_ITEMS) {
        cellText = [eventItemsArray objectAtIndex:indexPath.row];
    } else if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_MEMBERS) {
        cellText = [eventMembersArray objectAtIndex:indexPath.row];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = cellText;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}


#pragma mark -- Tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TODO -- check for indexpath
    NSLog(@"here here");
    BaseViewController *pushedVc = nil;
    if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_ITEMS) {
        pushedVc = [[EventItemViewController alloc] init];
    } else if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_MEMBERS) {
        pushedVc = [[EventMemberViewController alloc] init];
    }
    
    NSLog(@"EHEH");
    
    [self.navigationController pushViewController:pushedVc animated:YES];
    
}


@end
