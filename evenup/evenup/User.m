//
//  User.m
//  evenup
//
//  Created by Kyle Connors on 2/23/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "User.h"

@implementation User
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.first_name = dictionary[@"first_name"];
        self.last_name = dictionary[@"last_name"];
        self.email = dictionary[@"email"];
        self.phone = dictionary[@"phone"];
    }
    return self;
    
}
    
@end
