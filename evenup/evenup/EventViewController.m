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
#import "EventItem.h"
#import "EventItemCell.h"
#import "EventMemberCell.h"
#import "AddDeviceContactsViewController.h"
#import "ContactsData.h"
@interface EventViewController () <UITableViewDataSource, UITableViewDelegate,MCSwipeTableViewCellDelegate, AddItemViewDelegate, AddDeviceContactsViewControllerDelegate>
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
    self.title = _event.title;
    
//    TODO -- only an admin should see this
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(showAdminView)];
    toggleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Items", @"Members"]];
    toggleSegment.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 30);
    [toggleSegment addTarget:self action:@selector(didChangeSegmentValue:) forControlEvents:UIControlEventValueChanged];
    toggleSegment.tintColor = [Utils Color4];
    toggleSegment.selectedSegmentIndex = 0;

    [self.view addSubview:toggleSegment];
    
    addItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addItem = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, self.view.frame.size.width-40, 35)];
    [addItem setTitle:@"ADD ITEM +" forState:UIControlStateNormal];
    addItem.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [addItem setTitleColor:[Utils Color5] forState:UIControlStateNormal];
    [addItem addTarget:self action:@selector(addItemToEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addItem];
    
    addMember = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, self.view.frame.size.width-40, 35)];
    [addMember setTitle:@"ADD MEMBER +" forState:UIControlStateNormal];
    [addMember setTitleColor:[Utils Color5] forState:UIControlStateNormal];
    [addMember addTarget:self action:@selector(addMemberToEvent) forControlEvents:UIControlEventTouchUpInside];
    addMember.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [addMember setHidden:YES];
    
    [self.view addSubview:addMember];
    
    
    
    eventTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-85) style:UITableViewStylePlain];
    eventTable.dataSource = self;
    eventTable.delegate = self;
    
    [self.view addSubview:eventTable];
    
    
//    eventItemsArray = [NSArray arrayWithObjects:@"Item 1", @"Item 2", nil];
//    eventMembersArray = [NSArray arrayWithObjects:@"Member 1", @"Member 2", nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchBills];
    [self fetchMembers];
}

-(void)fetchBills
{
    

    NSString *url = [NSString stringWithFormat:EVENT_BILL_ITEMS_URL, _event.event_id];

    [[Server sharedServer] requestOfType:GET_REQUEST forUrl:url params:nil target:self successMethod:@selector(billItemSuccessResponse:) errorMethod:@selector(billItemsErrorResponse:)];
    
}

#pragma mark -- Server responses
-(void)billItemSuccessResponse:(NSObject *)response
{
    NSLog(@"response is %@", response);
    NSMutableArray *array = [response valueForKey:@"results"];
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *dict in array) {
        EventItem *item = [[EventItem alloc] initWithDictionary:dict];
        [newArray addObject:item];
    }
    
    
    eventItemsArray = newArray;
    [eventTable reloadData];
    
    
}

-(void)billItemsErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);

}

-(void)fetchMembers
{
    
    
    NSString *url = [NSString stringWithFormat:EVENT_BILL_MEMBERS_URL, _event.event_id];
    
    [[Server sharedServer] requestOfType:GET_REQUEST forUrl:url params:nil target:self successMethod:@selector(billMemberSuccessResponse:) errorMethod:@selector(billMemberErrorResponse:)];
    
}

#pragma mark -- Server responses
-(void)billMemberSuccessResponse:(NSObject *)response
{
    NSMutableArray *array = [response valueForKey:@"results"];
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *dict in array) {
        EventMember *member= [[EventMember alloc] initWithDictionary:dict];
        [newArray addObject:member];
    }
    
    
    eventMembersArray = newArray;
    [eventTable reloadData];
    
    
}

-(void)billMemberErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);
    
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
    addView.delegate = self;
    addView.eventId = _event.event_id;
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
#pragma mark -- add device stuff
-(void)addMemberToEvent
{
    AddDeviceContactsViewController *addDeviceVc = [[AddDeviceContactsViewController alloc] initWithContacts:[Utils getAllContacts]];
    
//    [self presentViewController:addDeviceVc animated:YES completion:nil];
    [self showModalViewController:addDeviceVc];
    addDeviceVc.delegate = self;
}

-(void)AddDeviceViewController:(AddDeviceContactsViewController *) viewController selectedContacts:(NSMutableArray *)contacts
{

    [self createEventContactsWithContacts:contacts];

    
}

-(void)createEventContactsWithContacts:(NSMutableArray *)contacts
{
    if (contacts.count > 0) {
        for (ContactsData *contact in contacts) {
            NSString *name = [NSString stringWithFormat:@"%@ %@", contact.firstNames, contact.lastNames];
            NSString *number = [contact.phoneNumbers objectAtIndex:0];
            
            NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] init];
            
            [paramsDict setObject:name forKey:@"name"];
            [paramsDict setObject:number forKey:@"phone"];
            
            
            NSString *url = [NSString stringWithFormat:EVENT_BILL_MEMBERS_URL, _event.event_id];
            
            [[Server sharedServer] requestOfType:POST_REQUEST forUrl:url params:paramsDict target:self successMethod:@selector(addContactsSuccessResponse:) errorMethod:@selector(addContactsErrorResponse:)];
        };
        
        
        
        
    }
    
    
    
}

#pragma mark -- Server responses
-(void)addContactsSuccessResponse:(NSObject *)response
{
    NSLog(@"response is %@", response);
    [self fetchMembers];

    
}

-(void)addContactsErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);
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

#pragma mark AdditemDelegate
-(void)AddItemView:(AddItemView *) view didAddItem:(EventItem *)item
{
//    TODO -- add item to the array;
    [self fetchBills];
    [self hideAndRemoveAddView:view];
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
    

    BOOL display_items = NO;

    
    if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_ITEMS) {
//        cellText = [eventItemsArray objectAtIndex:indexPath.row];
        EventItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        display_items = YES;
        
        if (cell == nil) {
            cell = [[EventItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.contentView.backgroundColor = [UIColor whiteColor];
        EventItem *item = [eventItemsArray objectAtIndex:indexPath.row];
        [cell setItem:item];
        cell = [self ItemCellfromCell:cell WithItem:item];
        
        return cell;

    } else if (toggleSegment.selectedSegmentIndex == EVENT_TOGGLE_MEMBERS) {
//        cellText = [eventMembersArray objectAtIndex:indexPath.row];
        display_items = NO;
        EventMemberCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell2 == nil) {
            cell2 = [[EventMemberCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
            
        }
        
        
        EventMember *eventMem = [eventMembersArray objectAtIndex:indexPath.row];

        [cell2 setMember:eventMem];
        
        return cell2;
        
    }
    
//    if (display_items) {
//        return cell;
//    } else {
//        return cell2;
//    }
    UITableViewCell *othaCell = [[UITableViewCell alloc] init];

    return othaCell;
}

// EVENT ITEM CELL 
-(EventItemCell *)ItemCellfromCell:(EventItemCell*) cell WithItem:(EventItem *) event_item{

    
    cell.backgroundColor = [UIColor clearColor];
    // Configuring the views and colors.
    UILabel *splitItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    splitItem.text = @"Split Item";
    splitItem.textColor = [UIColor darkGrayColor];
    splitItem.font = [UIFont boldSystemFontOfSize:18.0];
    
    UILabel *splittingItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    splittingItem.text = @"Splitting Item!";
    splittingItem.textColor = [UIColor whiteColor];
    splittingItem.font = [UIFont boldSystemFontOfSize:18.0];
    
    
    UILabel *NotsplitItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    NotsplitItem.text = @"Removing Split";
    NotsplitItem.font = [UIFont boldSystemFontOfSize:18.0];
    NotsplitItem.textColor = [UIColor darkGrayColor];
    NotsplitItem.textAlignment = NSTextAlignmentRight;
    
    UILabel *NotsplittingItem = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    NotsplittingItem.text = @"Removing Split!";
    NotsplittingItem.font = [UIFont boldSystemFontOfSize:18.0];
    NotsplittingItem.textColor = [UIColor whiteColor];
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
            
            NSString *url = [NSString stringWithFormat:EVENT_BILL_SPLITTERS_URL, _event.event_id, event_item.item_id];
            
            [[Server sharedServer] requestOfType:POST_REQUEST forUrl:url params:nil target:self successMethod:@selector(addAsSplitterSuccessResponse:) errorMethod:@selector(AddAsSplitterErrorResponse:)];
            
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
            NSString *url = [NSString stringWithFormat:EVENT_BILL_SPLITTERS_URL, _event.event_id, event_item.item_id];
            
            [[Server sharedServer] requestOfType:DELETE_REQUEST forUrl:url params:nil target:self successMethod:@selector(addAsSplitterSuccessResponse:) errorMethod:@selector(AddAsSplitterErrorResponse:)];
            
            
            EventItemCell *cellSplit = cell;
            [cellSplit removeSetAsSplit];
        }];
        
        
    }];
    
    
    
    
    cell.delegate = self;
    cell.firstTrigger = 0.2;
    cell.secondTrigger = 0.7;
    return cell;
    
}

-(void)addAsSplitterSuccessResponse:(NSObject *)response
{
    NSLog(@"response is %@", response);
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self fetchBills];
    
}

-(void)AddAsSplitterErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);
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
    
    
    [self.navigationController pushViewController:pushedVc animated:YES];
    
}

#pragma mark - MCSwipeTableViewCellDelegate

// Called when the user starts swiping the cell.
- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell
{
    
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
