//
//  ContactsData.h
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsData : NSObject


@property (nonatomic, strong) NSString *firstNames;
@property (nonatomic, strong) NSString *lastNames;
@property (nonatomic, strong) NSString *fullName;
@property(nonatomic, strong) NSMutableArray *phoneNumbers;
@property(nonatomic, strong) NSMutableArray *emailAddresses;
-(NSString *)fullName;
-(void)setNumbers:(NSMutableArray *)numbers;
-(void)setEmails:(NSMutableArray *)emails;

@end
