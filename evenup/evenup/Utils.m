//
//  Utils.m
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "Utils.h"
#import "ContactsData.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation Utils


+ (UIColor *)Color1
{
    return [UIColor colorWithRed:93/255.0f green:207/255.0f blue:195/255.0f alpha:1.0f];
}

+ (UIColor *)Color2
{
    return [UIColor colorWithRed:52/255.0f green:207/255.0f blue:190/255.0f alpha:1.0f];
}

+ (UIColor *)Color3
{
    return [UIColor colorWithRed:0/255.0f green:158/255.0f blue:142/255.0f alpha:1.0f];
}

+ (UIColor *)Color4
{
    return [UIColor colorWithRed:30/255.0f green:119/255.0f blue:109/255.0f alpha:1.0f];
}

+(UIColor *)Color5
{
    return [UIColor colorWithRed:0/255.0f green:103/255.0f blue:92/255.0f alpha:1.0f];
}



+(NSArray *)getAllContacts
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
            
            
            contacts.firstNames = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            
            contacts.lastNames =  CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));

            
            if (!contacts.firstNames) {
                contacts.firstNames = @"";
            }
            if (!contacts.lastNames) {
                contacts.lastNames = @"";
            }
            
            contacts.fullName = [NSString stringWithFormat:@"%@ %@", contacts.firstNames, contacts.lastNames];
            
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
