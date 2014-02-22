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


@interface EventViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *eventTable;
    UISegmentedControl *toggleSegment;
    
    NSArray *eventItemsArray;
    NSArray *eventMembersArray;
    
    UIButton *addItem;
    UIButton *addMember;
    
    UIView *darkBGView;
    

}
@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Event Title";
    toggleSegment = [[UISegmentedControl alloc] initWithItems:@[@"Items", @"Members"]];
    toggleSegment.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 30);
    [toggleSegment addTarget:self action:@selector(didChangeSegmentValue:) forControlEvents:UIControlEventValueChanged];
    toggleSegment.selectedSegmentIndex = 0;
//    toggleSegment.backgroundColor = [UIColor greenColor];
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(viewTouched)];
    
    [self.view addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

-(void)showMembers
{
    [addItem setHidden:YES];
    [addMember setHidden:NO];
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
