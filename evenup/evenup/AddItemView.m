//
//  AddItemView.m
//  evenup
//
//  Created by Kyle Connors on 2/21/14.
//  Copyright (c) 2014 Kyle Connors. All rights reserved.
//

#import "AddItemView.h"
#import "BaseCell.h"

@interface AddItemView () <UITableViewDelegate, UITableViewDataSource>
{
    UILabel *titleLabel;
    UIButton *addButton;
    
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
        titleLabel.text = @"Add Item";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        self.formTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, frame.size.height-50) style:UITableViewStyleGrouped];
        self.layer.cornerRadius = 5;
        self.formTable.delegate = self;
        self.formTable.dataSource = self;
        self.formTable.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.formTable];
        
        addButton = [[UIButton alloc] init];
        [addButton setTitle:@"Add Item" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(didSelectAdd) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:addButton];
        
        
    }
    return self;
}

-(void)adjustFrame:(CGRect)frame
{
    self.frame = frame;
    self.formTable.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-100);
    addButton.frame = CGRectMake(20, self.formTable.frame.size.height+self.formTable.frame.origin.y+30, frame.size.width-40, 20);
}

-(void)didSelectAdd
{
    
}

#pragma mark -- Tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *formCell = [[BaseCell alloc] initAsCellTextField];
    NSString *textLabel = nil;
    NSString *textPlaceHolder = nil;
    switch (indexPath.row) {
        case 0:
            textLabel = @"Item Name";
            textPlaceHolder = @"";
            break;
        case 1:
            textLabel = @"Item Price";
            textPlaceHolder = @"";
            break;
        case 2:
            textLabel = @"Split Item";
            textPlaceHolder = @"";
            
        default:
            break;
    }
    formCell.selectionStyle = UITableViewCellSelectionStyleNone;
    formCell.textLabel.text = textLabel;
    formCell.textField.placeholder = textPlaceHolder;
    return formCell;
}
@end
