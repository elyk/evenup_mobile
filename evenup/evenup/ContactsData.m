//
//  ContactsData.m
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "ContactsData.h"

@implementation ContactsData


-(void)setEmails:(NSMutableArray *)emails
{
    if (emails) {
        self.emailAddresses = emails;
    }

}

-(void)setNumbers:(NSMutableArray *)numbers
{
    if (numbers) {
        self.phoneNumbers = numbers;
    }

}

//-(NSString *)fullName
//{
//    return [NSString stringWithFormat:@"%@ %@", self.firstNames, self.lastNames];
//}

@end
