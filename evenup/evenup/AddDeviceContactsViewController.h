//
//  AddDeviceContactsViewController.h
//  evenup
//
//  Created by Kyle Connors on 2/22/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "BaseViewController.h"
#import "THContactPickerView.h"
@protocol AddDeviceContactsViewControllerDelegate;


@interface AddDeviceContactsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, THContactPickerDelegate>


@property (nonatomic, weak) id<AddDeviceContactsViewControllerDelegate> delegate;

@property (nonatomic, strong) THContactPickerView *contactPickerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSMutableArray *selectedContacts;
@property (nonatomic, strong) NSArray *filteredContacts;

-(id)initWithContacts:(NSArray *)contacts;
@end

@protocol AddDeviceContactsViewControllerDelegate <NSObject>

-(void)AddDeviceViewController:(AddDeviceContactsViewController *) viewController selectedContacts:(NSMutableArray *)contacts;

@end