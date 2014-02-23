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
#import "Event.h"
#import "EventItem.h"
#import "EventItemCell.h"
@interface EventViewController () <UITableViewDataSource, UITableViewDelegate,MCSwipeTableViewCellDelegate>
{
    UITableView *eventTable;
    UISegmentedControl *toggleSegment;
    
    NSArray *eventItemsArray;
    NSArray *eventMembersArray;
    
    UIButton *addItem;
    UIButton *addMember;
    
    UIView *darkBGView;
    
    UITapGestureRecognizer *tapGesture;
    
    Event *_event;

}
@end

@implementation EventViewController

-(id)initWithEvent:(Event *)event
{
    self = [super init];
    if (self){
        _event = event;
    }
    
    return self;
}

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
    toggleSegment.tintColor = [Utils Color4];
    toggleSegment.selectedSegmentIndex = 0;

    [self.view addSubview:toggleSegment];
    
    addItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addItem = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, self.view.frame.size.width-40, 30)];
    [addItem setTitle:@"Add Item +" forState:UIControlStateNormal];

    [addItem setTitleColor:[Utils Color5] forState:UIControlStateNormal];
    [addItem addTarget:self action:@selector(addItemToEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addItem];
    
    addMember = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, self.view.frame.size.width-40, 30)];
    [addMember setTitle:@"Add Member +" forState:UIControlStateNormal];
    [addMember setTitleColor:[Utils Color5] forState:UIControlStateNormal];
    [addMember addTarget:self action:@selector(addMemberToEvent) forControlEvents:UIControlEventTouchUpInside];
    [addMember setHidden:YES];
    [self.view addSubview:addMember];
    
    
    
    eventTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, self.view.frame.size.height-85) style:UITableViewStylePlain];
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
    
    EventItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[EventItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSString *cellText = nil;
    
    if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_ITEMS) {
        cellText = [eventItemsArray objectAtIndex:indexPath.row];
    } else if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_MEMBERS) {
        cellText = [eventMembersArray objectAtIndex:indexPath.row];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    [cell setItem:nil];
    
    
    // Configuring the views and colors.
    UILabel *splitItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    splitItem.text = @"Split Item";
    splitItem.textColor = [UIColor lightGrayColor];
    splitItem.font = [UIFont boldSystemFontOfSize:18.0];

    UILabel *splittingItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    splittingItem.text = @"Splitting Item!";
    splittingItem.textColor = [UIColor darkGrayColor];
    splittingItem.font = [UIFont boldSystemFontOfSize:18.0];
  
    
    UILabel *NotsplitItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    NotsplitItem.text = @"Removing Split";
    NotsplitItem.font = [UIFont boldSystemFontOfSize:18.0];
    NotsplitItem.textColor = [UIColor lightGrayColor];
    NotsplitItem.textAlignment = NSTextAlignmentRight;
    
    UILabel *NotsplittingItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    NotsplittingItem.text = @"Removing Split!";
    NotsplittingItem.font = [UIFont boldSystemFontOfSize:18.0];
    NotsplittingItem.textColor = [UIColor darkGrayColor];
    NotsplittingItem.textAlignment = NSTextAlignmentRight;
    
    
    
    

    // Starting to add
    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    
    // ADDED
    UIColor *darkGreenColor = [UIColor colorWithRed:51/255.0f green:147/255.0f blue:0/255.0f alpha:1.0f];
    

    UIColor *redColor = [UIColor colorWithRed:252/255.0f green:35/255.0f blue:35/255.0f alpha:1.0f];
    

    UIColor *darkRedColor = [UIColor colorWithRed:173/255.0f green:24/255.0f blue:24/255.0f alpha:1.0f];
    
    // Setting the default inactive state color to the tableView background color.
//    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    

    
    // Adding gestures per state basis.
    [cell setSwipeGestureWithView:splitItem color:greenColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Checkmark\" cell");
    }];
    
    [cell setSwipeGestureWithView:splittingItem color:darkGreenColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did add self to item");
        NSLog(@"Did remove self from item");
        [cell swipeToOriginWithCompletion:^{
            NSLog(@"Cell swiped back!");
            EventItemCell *cellSplit = cell;
            [cellSplit setAsSplit];
        }];
        
    }];
    
    [cell setSwipeGestureWithView:NotsplitItem color:redColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Clock\" cell");
    }];
    
    [cell setSwipeGestureWithView:NotsplittingItem color:darkRedColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState4 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did remove self from item");
        [cell swipeToOriginWithCompletion:^{
            NSLog(@"Cell swiped back!");
            EventItemCell *cellSplit = cell;
            [cellSplit removeSetAsSplit];
        }];
        
        
    }];

    
    
    
    cell.delegate = self;
    cell.firstTrigger = 0.2;
    cell.secondTrigger = 0.7;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseViewController *pushedVc = nil;
    if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_ITEMS) {
        pushedVc = [[EventItemViewController alloc] init];
    } else if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_MEMBERS) {
        pushedVc = [[EventMemberViewController alloc] init];
    }
    
    NSLog(@"EHEH");
    
    [self.navigationController pushViewController:pushedVc animated:YES];
    
}

#pragma mark - MCSwipeTableViewCellDelegate

// Called when the user starts swiping the cell.
- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell
{
    NSLog(@"heee");
}

// Called when the user ends swiping the cell.
- (void)swipeTableViewCellDidEndSwiping:(MCSwipeTableViewCell *)cell
{
    NSLog(@"heee");

}

// Called during a swipe.
//- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didSwipeWithPercentage:(CGFloat)percentage
//{
//    NSLog(@"heee");
//}


@end
