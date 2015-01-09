//
//  ABCCartViewController.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "ABCCartViewController.h"
#import "ABCCartFactory.h"
#import "ABCCartTableViewCell.h"

@interface ABCCartViewController ()

@end

@implementation ABCCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (void) dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ABCCartFactory defaultCart] allProductsInCart].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ABCCartTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CartCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(ABCCartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* items = [[ABCCartFactory defaultCart] allProductsInCart];
    ABCProduct* product = items.allKeys[indexPath.row];
    NSInteger count = [items[product] integerValue];
    cell.nameLabel.text = [NSString stringWithFormat:@"(%ld) %@",(long)count,product.name];
    
    //Hook up the increment/decrement buttons
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(addProduct:) forControlEvents:UIControlEventTouchUpInside];
    cell.subtractButton.tag = indexPath.row;
    [cell.subtractButton addTarget:self action:@selector(subtractProduct:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addProduct:(UIButton*)sender {
    NSInteger row = sender.tag;
    ABCProduct* product = [[ABCCartFactory defaultCart] allProductsInCart].allKeys[row];
    [[ABCCartFactory defaultCart] addProduct:product quantity:1];
    [self.tableView reloadData];
}

- (void)subtractProduct:(UIButton*)sender {
    NSInteger row = sender.tag;
    ABCProduct* product = [[ABCCartFactory defaultCart] allProductsInCart].allKeys[row];
    [[ABCCartFactory defaultCart] addProduct:product quantity:-1];
    [self.tableView reloadData];
}

#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //Check to see if the cart is empty.  If so, warn the user.
    if([identifier isEqualToString:@"showPayment"]) {
        if([[ABCCartFactory defaultCart] allProductsInCart].count == 0){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Cart is empty" message:@"Add some products before going to payment" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return NO;
        }
    }
    
    return YES;
}


@end
