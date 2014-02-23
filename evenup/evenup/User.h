//
//  User.h
//  evenup
//
//  Created by Kyle Connors on 2/23/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

-(id)initWithDictionary:(NSDictionary *)dictionary;
@property(nonatomic, strong) NSString *first_name;
@property(nonatomic, strong) NSString *last_name;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *phone;
@end
