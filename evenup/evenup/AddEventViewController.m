//
//  AddEventViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "AddEventViewController.h"
#import "BaseCell.h"
@interface AddEventViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *addEventTableForm;
    UIButton *addEventButton;
}
@end

@implementation AddEventViewController

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
    self.title = @"New Event";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeCurrentView)];
    
    
    addEventTableForm = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) style:UITableViewStyleGrouped];
    addEventTableForm.delegate = self;
    addEventTableForm.dataSource = self;
    addEventTableForm.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:addEventTableForm];
    
    addEventButton = [[UIButton alloc] initWithFrame:CGRectMake(20, addEventTableForm.frame.size.height+addEventTableForm.frame.origin.y+20, self.view.frame.size.width-40, 50)];
    
    [addEventButton setTitle:@"Create Event" forState:UIControlStateNormal];
    [addEventButton setBackgroundColor:[UIColor redColor]];
    [addEventButton addTarget:self action:@selector(createNewEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addEventButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeCurrentView
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)createNewEvent
{
    
}

#pragma mark -- Tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *formCell = [[BaseCell alloc] initAsCellTextField];
    NSString *textLabel = nil;
    NSString *textPlaceHolder = nil;
    switch (indexPath.row) {
        case 0:
            textLabel = @"Event Name";
            textPlaceHolder = @"enter name..";
            break;
        case 1:
            textLabel = @"Add contacts";
            textPlaceHolder = @"Enter Password";
        default:
            break;
    }
    formCell.selectionStyle = UITableViewCellSelectionStyleNone;
    formCell.textLabel.text = textLabel;
    formCell.textField.placeholder = textPlaceHolder;
    return formCell;
}

@end
