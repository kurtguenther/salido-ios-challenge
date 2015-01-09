//
//  MasterViewController.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/7/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class ProductViewController;

@interface ProductListViewController : UITableViewController

@property (strong, nonatomic) ProductViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

