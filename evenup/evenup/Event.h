//
//  Event.h
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    
}

@property (nonatomic, strong) NSString *title;

-(id)initWithDictionary:(NSDictionary *)dictionary;
@end
