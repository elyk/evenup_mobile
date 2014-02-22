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
    NSLog(@"emails are %@", emails);
}

-(void)setNumbers:(NSMutableArray *)numbers
{
    NSLog(@"numbers are %@", numbers);
}

-(NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstNames, self.lastNames];
}

@end
