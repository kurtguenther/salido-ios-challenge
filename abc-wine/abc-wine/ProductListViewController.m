//
//  MasterViewController.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/7/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductViewController.h"
#import "ABCApiGateway.h"
#import "ABCProduct.h"
#import "ABCCartFactory.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import <EXTScope.h>

@interface ProductListViewController ()

/**
 *  This can be built out to be more robust, but for now it's just an in-memory representation
 */
@property (nonatomic, strong) NSMutableArray* productsCache;

@end

@implementation ProductListViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailViewController = (ProductViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //Setup the table for infinite scrolling
    @weakify(self);
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self);
        [self loadProducts];
    }];
    
    //Load the initial data
    self.productsCache = [NSMutableArray array];
    [self.tableView.infiniteScrollingView startAnimating];
    [self loadProducts];
}

/**
 *  Fetches products from the server.
 *  Either gets the initial products or fetches more in batches.
 */
- (void) loadProducts {
    [[ABCApiGateway sharedInstance] fetchProductsWithOffset:self.productsCache.count limit:30 success:^(NSArray *products) {
        //Animate because I'm not an feral animal
        [self.tableView beginUpdates];
        
        //Calculate the added index paths
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSInteger startingIndex = self.productsCache.count;
        for (int i = 0; i < products.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:startingIndex++ inSection:0]];
        }
        
        //Add to the backing datasource
        [self.productsCache addObjectsFromArray:products];
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        
        //Stop refresh
        [self.tableView.infiniteScrollingView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Server Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = sender;
        ABCProduct* product = self.productsCache[indexPath.row];
        
        ProductViewController* controller = (ProductViewController *)[[segue destinationViewController] topViewController];
        controller.product = product;

        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //Check to see if the cart is empty.  If so, warn the user.
    if([identifier isEqualToString:@"showCart"]) {
        if([[ABCCartFactory defaultCart] allProductsInCart].count == 0){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Cart is empty" message:@"Add some products before going to the cart" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsCache.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ABCProduct* product = self.productsCache[indexPath.row];
    cell.textLabel.text = product.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
    
}

@end
