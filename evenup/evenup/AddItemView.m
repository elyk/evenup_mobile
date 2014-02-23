//
//  AddItemView.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "AddItemView.h"
#import "BaseCell.h"
#import "Utils.h"
@interface AddItemView () <UITableViewDelegate, UITableViewDataSource>
{
    UILabel *titleLabel;
    UIButton *addButton;
    BaseCell *itemNameCell;
    BaseCell *itemPriceCell;
    
}
@end

@implementation AddItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 25)];
        titleLabel.text = @"ADD ITEM TO EVENT";
        titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        titleLabel.textColor = [Utils Color4];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        
        itemNameCell = [[BaseCell alloc] initAsCellTextField];
        itemNameCell.textLabel.text = @"Item Name";
        
        itemPriceCell = [[BaseCell alloc] initAsCellTextField];
        itemPriceCell.textLabel.text = @"Item Price";
        itemPriceCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        
        self.formTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, frame.size.height-50) style:UITableViewStyleGrouped];
        self.layer.cornerRadius = 5;
        self.formTable.delegate = self;
        self.formTable.dataSource = self;
        self.formTable.scrollEnabled = NO;
        self.formTable.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.formTable];
        
        addButton = [[UIButton alloc] init];
        [addButton setTitle:@"ADD ITEM" forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [addButton setTitleColor:[Utils Color5] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(didSelectAdd) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:addButton];
        
        
        
    }
    return self;
}

-(void)adjustFrame:(CGRect)frame
{
    self.frame = frame;
    self.formTable.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-150);
    addButton.frame = CGRectMake(20, self.formTable.frame.size.height+self.formTable.frame.origin.y+20, frame.size.width-40, 20);

//    letting parent view know we are displayed
    self.is_displayed = YES;
}

-(void)didSelectAdd
{
    [self.delegate AddItemView:self didAddItem:nil];
}

#pragma mark -- Tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *formCell = [[BaseCell alloc] initAsCellTextField];
    NSString *textLabel = nil;
    NSString *textPlaceHolder = nil;
    switch (indexPath.row) {
        case 0:
            formCell = itemNameCell;
            break;
        case 1:
            formCell = itemPriceCell;
            break;
        case 2:
            textLabel = @"Split Item";
            textPlaceHolder = @"";
            
        default:
            break;
    }
    formCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return formCell;
}
@end
