//
//  PaymentViewController.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "PaymentViewController.h"
#import "BaseCell.h"
#import "STPCard.h"
#import "Stripe.h"
@interface PaymentViewController () <UITableViewDataSource, UITableViewDelegate>
{
    STPCard *stripeCreditCard;
    UITableView *formTableView;
    
    UIButton *saveButton;
    
    BaseCell *CreditCardNumberCell;
    BaseCell *CreditCardMonthCell;
    BaseCell *CreditCardYearCell;
}
@end

@implementation PaymentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Payment Details";
    
    [self setLeftMenuButton];
    
    formTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 220) style:UITableViewStyleGrouped];
    formTableView.backgroundColor = [UIColor clearColor];
    formTableView.dataSource = self;
    formTableView.delegate = self;
    formTableView.scrollEnabled = NO;
    [self.view addSubview:formTableView];
    
    saveButton = [[UIButton alloc] initWithFrame:CGRectMake(20, formTableView.frame.size.height+formTableView.frame.origin.y+10, self.view.frame.size.width-40, 20)];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(sendCreditCard) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
    
    CreditCardNumberCell = [[BaseCell alloc] initAsCellTextField];
    CreditCardNumberCell.textLabel.text = @"Card Number";
    CreditCardNumberCell.textField.keyboardType = UIKeyboardTypeNumberPad;

    CreditCardMonthCell = [[BaseCell alloc] initAsCellTextField];
    CreditCardMonthCell.textLabel.text = @"Exp Month";
    CreditCardMonthCell.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    CreditCardYearCell = [[BaseCell alloc] initAsCellTextField];
    CreditCardYearCell.textLabel.text = @"Exp Year";
    CreditCardYearCell.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
}

-(void)sendCreditCard
{
    STPCard *card = [[STPCard alloc] init];
    card.number = CreditCardNumberCell.textField.text;
    card.expMonth = [CreditCardMonthCell.textField.text intValue];
    card.expYear = [CreditCardYearCell.textField.text intValue];
    
    [Stripe createTokenWithCard:card
                 publishableKey:STRIPE_SETTINGS_KEY
                     completion:^(STPToken *token, NSError *error) {
                         if (error) {
                             NSLog(@"error is %@", error);
                         } else {
                             [self sendStripeTokenToServer:token]; // Hooray!
                         }
                     }];
    
    
}

-(void)sendStripeTokenToServer:(STPToken *)token
{
    NSLog(@"stripe token back is %@", token);
}

#pragma mark -- Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *formCell = nil;
    switch (indexPath.row) {
        case 0:
            formCell = CreditCardNumberCell;
            break;
        case 1:
            formCell = CreditCardMonthCell;
            break;
        case 2:
            formCell = CreditCardYearCell;
            break;
        default:
            break;
    }
    formCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return formCell;
}

@end
