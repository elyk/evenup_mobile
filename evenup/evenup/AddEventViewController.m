//
//  AddEventViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "AddEventViewController.h"
#import "BaseCell.h"
#import "AddDeviceContactsViewController.h"
#import <MessageUI/MessageUI.h>
#import "ContactsData.h"
@interface AddEventViewController () <UITableViewDataSource, UITableViewDelegate, AddDeviceContactsViewControllerDelegate, MFMessageComposeViewControllerDelegate>
{
    UITableView *addEventTableForm;
    UIButton *addEventButton;
    AddDeviceContactsViewController *addDeviceContactsVc;
    BaseCell *eventTitleName;
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStyleDone target:self action:@selector(createNewEvent)];
    
    
    eventTitleName = [[BaseCell alloc] initAsCellTextField];
    eventTitleName.textLabel.text = @"Event Name";
    eventTitleName.selectionStyle = UITableViewCellSelectionStyleNone;
    
    addEventTableForm = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) style:UITableViewStylePlain];
    addEventTableForm.delegate = self;
    addEventTableForm.dataSource = self;
    addEventTableForm.scrollEnabled = NO;
    addEventTableForm.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:addEventTableForm];
    
    NSArray *contacts = [Utils getAllContacts];
    addDeviceContactsVc = [[AddDeviceContactsViewController alloc] initWithContacts:contacts];
    addDeviceContactsVc.delegate = self;
    addDeviceContactsVc.view.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-addEventTableForm.frame.size.height);
    
    [self.view addSubview:addDeviceContactsVc.view];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNewEvent
{

    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] init];
    [paramsDict setObject:eventTitleName.textField.text forKey:@"title"];
    
    [[Server sharedServer] requestOfType:POST_REQUEST forUrl:EVENTS_URL params:paramsDict target:self successMethod:@selector(newEventsSuccessResponse:) errorMethod:@selector(newEventsErrorResponse:)];

}

-(void)getSelectedContacts
{
    NSMutableArray *recipents = [[NSMutableArray alloc] init];
    
    for (ContactsData *selectedContact in addDeviceContactsVc.selectedContacts) {
        
        NSString *selectedPhoneNumber = [selectedContact.phoneNumbers objectAtIndex:0];
        [recipents addObject:selectedPhoneNumber];
        
        
    }
    
    NSLog(@"recipents are %@", recipents);
    
    NSLog(@"the selected contacts %@", addDeviceContactsVc.selectedContacts);
    NSString *eventMessage = [NSString stringWithFormat:@"Hi all. please join my EvenUp to %@", eventTitleName.textField.text];
    [self sendTextMessage:eventMessage toRecipents:[NSArray arrayWithArray:recipents]];
    
}



-(void)newEventsSuccessResponse:(NSObject *)response
{
    NSLog(@"response is %@", response);
    
}

-(void)newEventsErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);
}

#pragma mark -- Tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return eventTitleName;
}


-(void)AddDeviceViewController:(AddDeviceContactsViewController *) viewController selectedContacts:(NSMutableArray *)contacts
{
    NSLog(@"contacts are %@", contacts);
}


-(void)sendTextMessage:(NSString *)message toRecipents:(NSArray *)array
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = message;
        controller.recipients = array;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"result is %u", result);
    if (result==MessageComposeResultCancelled) {
        
    } else if (result==MessageComposeResultSent) {
//        create the event members!
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end



