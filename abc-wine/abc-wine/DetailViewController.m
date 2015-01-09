//
//  DetailViewController.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/7/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "DetailViewController.h"
#import "ABCCartFactory.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)setProduct:(ABCProduct *)product {
    if(_product != product){
        _product = product;
        [self configureView];
    }
}

- (void)configureView {
    self.productName.text = self.product.name;
}

#pragma mark Actions

- (void)addToCart:(id)sender {
    if(self.product){
        [[ABCCartFactory defaultCart] addProduct:self.product quantity:1];
    }
}



@end
