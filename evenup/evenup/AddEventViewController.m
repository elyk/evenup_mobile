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
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactsData.h"
@interface AddEventViewController () <UITableViewDataSource, UITableViewDelegate, ABPeoplePickerNavigationControllerDelegate>
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
    addEventTableForm = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) style:UITableViewStyleGrouped];
    addEventTableForm.delegate = self;
    addEventTableForm.dataSource = self;
    addEventTableForm.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:addEventTableForm];
    
    addEventButton = [[UIButton alloc] initWithFrame:CGRectMake(20, addEventTableForm.frame.size.height+addEventTableForm.frame.origin.y+20, self.view.frame.size.width-40, 50)];
    
    [addEventButton setTitle:@"Create Event" forState:UIControlStateNormal];
    [addEventButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addEventButton addTarget:self action:@selector(createNewEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addEventButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNewEvent
{

    NSArray *contacts = [self getAllContacts];
    AddDeviceContactsViewController *addDeviceContacts = [[AddDeviceContactsViewController alloc] initWithContacts:contacts];
    
    [self showModalViewController:addDeviceContacts];
    
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
            textPlaceHolder = @"";
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


-(NSArray *)getAllContacts
{
    
    CFErrorRef *error = nil;
    
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted) {
        
#ifdef DEBUG
        NSLog(@"Fetching contact info ----> ");
#endif
        
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        NSMutableArray* items = [NSMutableArray arrayWithCapacity:nPeople];
        
        
        for (int i = 0; i < nPeople; i++)
        {
            ContactsData *contacts = [ContactsData new];
            
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            
            //get First Name and Last Name
            
            contacts.firstNames = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            NSLog(@"fname %@", contacts.firstNames);
            
            contacts.lastNames =  (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
            
            if (!contacts.firstNames) {
                contacts.firstNames = @"";
            }
            if (!contacts.lastNames) {
                contacts.lastNames = @"";
            }
            
            // get contacts picture, if pic doesn't exists, show standart one
            
//            NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(person);
//            contacts.image = [UIImage imageWithData:imgData];
//            if (!contacts.image) {
//                contacts.image = [UIImage imageNamed:@"NOIMG.png"];
//            }
            //get Phone Numbers
            
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            
            ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            for(CFIndex i=0;i<ABMultiValueGetCount(multiPhones);i++) {
                
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                NSString *phoneNumber = (__bridge NSString *) phoneNumberRef;
                [phoneNumbers addObject:phoneNumber];
                
                //NSLog(@"All numbers %@", phoneNumbers);
                
            }
            
            
            [contacts setNumbers:phoneNumbers];
            
            //get Contact email
            
            NSMutableArray *contactEmails = [NSMutableArray new];
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++) {
                CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                NSString *contactEmail = (__bridge NSString *)contactEmailRef;
                
                [contactEmails addObject:contactEmail];
                // NSLog(@"All emails are:%@", contactEmails);
                
            }
            
            [contacts setEmails:contactEmails];
            
            
            
            [items addObject:contacts];
            
#ifdef DEBUG
            //NSLog(@"Person is: %@", contacts.firstNames);
            //NSLog(@"Phones are: %@", contacts.numbers);
            //NSLog(@"Email is:%@", contacts.emails);
#endif
            
            
            
            
        }
        return items;
        
        
        
    } else {
#ifdef DEBUG
        NSLog(@"Cannot fetch Contacts :( ");        
#endif
        return NO;
        
        
    }
    
}




@end



