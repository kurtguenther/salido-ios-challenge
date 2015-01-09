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
}


@end
