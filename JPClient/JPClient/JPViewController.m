//
//  ViewController.m
//  JPClient
//
//  Created by Brian Olencki on 5/1/16.
//  Copyright © 2016 bolencki13. All rights reserved.
//

#import "JPViewController.h"
#import "JPMessagesViewController.h"

@interface JPViewController () <UITextFieldDelegate> {
    NSArray *aryTableView;
    
    UITextField *txtIPAddress;
    UITextField *txtPortNumber;
}
@end

@implementation JPViewController
- (instancetype)init {
    if (self == [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Connect";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(connect)];
    aryTableView = @[
                     @"IP Address:",
                     @"Port #:",
                     ];
    self.tableView.allowsSelection = NO;
}
- (void)connect {
    if (txtIPAddress.text != nil && ![txtIPAddress.text isEqualToString:@""] && txtPortNumber.text != nil && ![txtPortNumber.text isEqualToString:@""]) {
        JPMessagesViewController *messagesViewController = [[JPMessagesViewController alloc] initWithIPAddress:txtIPAddress.text withPort:txtPortNumber.text];
        if (messagesViewController  ) {
            [self.navigationController pushViewController:messagesViewController animated:YES];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"JPClient" message:@"Unable start UDP Client" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [aryTableView count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [aryTableView objectAtIndex:section];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIView *viewValid = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7.5, cell.frame.size.height)];
    viewValid.backgroundColor = [UIColor redColor];
    viewValid.tag = 1313;
    [cell.contentView addSubview:viewValid];
    
    if ([indexPath section] == 0) {
        txtIPAddress = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cell.frame.size.width-30, 30)];
        txtIPAddress.adjustsFontSizeToFitWidth = YES;
        txtIPAddress.textColor = [UIColor blackColor];
        txtIPAddress.placeholder = @"10.0.0.0";
        txtIPAddress.keyboardType = UIKeyboardTypeDecimalPad;
        txtIPAddress.returnKeyType = UIReturnKeyNext;
        txtIPAddress.backgroundColor = [UIColor whiteColor];
        txtIPAddress.autocorrectionType = UITextAutocorrectionTypeNo;
        txtIPAddress.autocapitalizationType = UITextAutocapitalizationTypeNone;
        txtIPAddress.textAlignment = NSTextAlignmentLeft;
        txtIPAddress.clearButtonMode = UITextFieldViewModeNever;
        [txtIPAddress setEnabled:YES];
        [txtIPAddress becomeFirstResponder];
        txtIPAddress.delegate = self;
        [cell.contentView addSubview:txtIPAddress];
    } else if ([indexPath section] == 1) {
        txtPortNumber = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, cell.frame.size.width-30, 30)];
        txtPortNumber.adjustsFontSizeToFitWidth = YES;
        txtPortNumber.textColor = [UIColor blackColor];
        txtPortNumber.placeholder = @"8080";
        txtPortNumber.keyboardType = UIKeyboardTypeNumberPad;
        txtPortNumber.returnKeyType = UIReturnKeyGo;
        txtPortNumber.backgroundColor = [UIColor whiteColor];
        txtPortNumber.autocorrectionType = UITextAutocorrectionTypeNo;
        txtPortNumber.autocapitalizationType = UITextAutocapitalizationTypeNone;
        txtPortNumber.textAlignment = NSTextAlignmentLeft;
        txtPortNumber.clearButtonMode = UITextFieldViewModeNever;
        txtPortNumber.delegate = self;
        [cell.contentView addSubview:txtPortNumber];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text != nil && ![textField.text isEqualToString:@""]) {
        [textField.superview viewWithTag:1313].backgroundColor = [UIColor greenColor];
    } else {
        [textField.superview viewWithTag:1313].backgroundColor = [UIColor redColor];
    }
}
@end
