//
//  Server.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "Server.h"
#import "AFHTTPRequestOperationManager.h"
#import "ContactsData.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@implementation Server

+(Server *)sharedServer
{
    static Server *server = nil;
    if (!server) {
        server = [[Server alloc] init];
        
    }
    return server;
}

-(void) requestOfType:(int)request_type forUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSLog(@"auth token is %@", [self authToken]);
//    [manager.requestSerializer setAuthorizationHeaderFieldWithToken:[self authToken]];
//    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[self authToken] password:nil];
    
    NSString *authString = [NSString stringWithFormat:@"Token %@", [self authToken]];
    [manager.requestSerializer setValue:authString forHTTPHeaderField:@"AUTHORIZATION"];

    
    
    //    incase isn't sent over'
    if (params == nil) {
        params = [[NSMutableDictionary alloc] init];
    }
    
//    [params setObject:[self authToken] forKey:@"token"];
    
    if (request_type==GET_REQUEST) {
        NSLog(@"request header is %@", manager.requestSerializer.HTTPRequestHeaders);
        [manager GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
    } else if (request_type==POST_REQUEST) {
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
        
    } else if (request_type==PATCH_REQUEST) {
        [manager PATCH:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
    } else if (request_type==PUT_REQUEST) {
        [manager PUT:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
    } else if (request_type==DELETE_REQUEST) {
        [manager DELETE:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
        
    }

    
}

-(void) authLoginRequest:(int)request_type forUrl:(NSString *)url params:(NSMutableDictionary *)params target:(id)target successMethod:(SEL)SuccessMethod errorMethod:(SEL)errorMethod
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    
    //    TODO -- do a check here for user params
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (request_type==POST_REQUEST) {
        [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [target performSelectorInBackground:SuccessMethod withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [target performSelectorInBackground:errorMethod withObject:error];
        }];
        
    }
}


-(void)setTheAuthToken:(NSString *)authToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:authToken forKey:USER_TOKEN_KEY];
    [defaults synchronize];
    self.authToken = authToken;
    
//    [[NSUserDefaults standardUserDefaults]
//     setObject:authToken forKey:USER_TOKEN_KEY];
}

-(void)LoadAuthToken
{
    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN_KEY];
}

-(void)removeAuthTok
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USER_TOKEN_KEY];
    [defaults synchronize];
    self.authToken = nil;
    
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
