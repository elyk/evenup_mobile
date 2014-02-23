//
//  EventCompleteViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/23/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "EventCompleteViewController.h"
#import "Event.h"
#import "PaymentViewController.h"
@interface EventCompleteViewController ()
{
    Event *_event;
    NSString *amountOwed;
    UILabel *amount;
}
@end

@implementation EventCompleteViewController

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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 75)];
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    label.textColor = [Utils Color5];
    label.text = [NSString stringWithFormat:@"%@ is complete.", _event.title];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILabel *whatOweLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 15)];
    whatOweLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    whatOweLabel.textColor = [UIColor lightGrayColor];
    whatOweLabel.textAlignment = NSTextAlignmentCenter;
    whatOweLabel.text = @"YOU OWE";
    [self.view addSubview:whatOweLabel];
    
    amount = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    amount.font = [UIFont boldSystemFontOfSize:18.0f];
    amount.textColor = [Utils Color5];
    amount.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:amount];
    
	// Do any additional setup after loading the view.
    UIButton *endEventButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 100)];
    [endEventButton setTitleColor:[Utils Color5] forState:UIControlStateNormal];
    [endEventButton setTitle:@"Pay Now" forState:UIControlStateNormal];
    [endEventButton addTarget:self action:@selector(endEvent) forControlEvents:UIControlEventTouchUpInside];
    endEventButton.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    
//
    [self.view addSubview:endEventButton];
    
    NSString *url = [NSString stringWithFormat:EVENT_DETAILS_URL, _event.event_id];
    NSString *url2 = [NSString stringWithFormat:@"%@closed/", url];
    
    [[Server sharedServer] requestOfType:GET_REQUEST forUrl:url2 params:nil target:self successMethod:@selector(newEventsSuccessResponse:) errorMethod:@selector(newEventsErrorResponse:)];
    
    
}

-(void)endEvent
{
    PaymentViewController *paymentVc = [[PaymentViewController alloc] initWithAmount:amountOwed];
    [self showModalViewController:paymentVc];
    
}
-(void)newEventsSuccessResponse:(NSObject *)response
{
    NSLog(@"response is %@", response);
    amountOwed = [response valueForKey:@"amount_owed"];
    amount.text = [NSString stringWithFormat:@"$%@", amountOwed];

    
}

-(void)newEventsErrorResponse:(NSObject *)response
{
    NSLog(@"error response is %@", response);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
