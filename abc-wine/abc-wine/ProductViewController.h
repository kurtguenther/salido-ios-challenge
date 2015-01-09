//
//  DetailViewController.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/7/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCProduct.h"

@interface ProductViewController : UIViewController

@property (nonatomic, strong) ABCProduct* product;

@property (nonatomic, strong) IBOutlet UILabel* productName;


- (IBAction)addToCart:(id)sender;

@end

