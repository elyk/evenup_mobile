//
//  EventAdminViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "EventAdminViewController.h"
#import "Event.h"
@interface EventAdminViewController ()
{
    Event *_event;
}
@end

@implementation EventAdminViewController

-(id)initWithEvent:(Event *)event
{
    self = [super init];
    if (self) {
        _event = event;
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"EvenUP Admin";
	// Do any additional setup after loading the view.
    UIButton *endEventButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 100)];
    [endEventButton setTitleColor:[Utils Color5] forState:UIControlStateNormal];
    [endEventButton setTitle:@"End Event" forState:UIControlStateNormal];
    [endEventButton addTarget:self action:@selector(endEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:endEventButton];
    
}

-(void)endEvent
{
    
    
    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] init];
    [paramsDict setObject:[NSNumber numberWithBool:NO] forKey:@"is_active"];
    
    NSString *string = [NSString stringWithFormat:EVENT_DETAILS_URL, _event.event_id];
    
    [[Server sharedServer] requestOfType:PATCH_REQUEST forUrl:string params:paramsDict target:self successMethod:@selector(newEventsSuccessResponse:) errorMethod:@selector(newEventsErrorResponse:)];
}
-(void)newEventsSuccessResponse:(NSObject *)response
{
    NSLog(@"response is %@", response);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)newEventsErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);
}

@end
