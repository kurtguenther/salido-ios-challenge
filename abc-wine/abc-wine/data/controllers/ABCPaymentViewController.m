//
//  ABCPaymentViewController.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "ABCPaymentViewController.h"
#import "ABCCartFactory.h"

@interface ABCPaymentViewController ()

@end

@implementation ABCPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Convert the items in the cart to an array of product ID => quantity
    //Since that's what we'd probably send over the wire for payment.
    
    NSDictionary* allItems = [[ABCCartFactory defaultCart] allProductsInCart];
    NSMutableArray* jsonArray = [NSMutableArray array];
    
    for(ABCProduct* key in allItems){
        [jsonArray addObject:@{@"product_id": key.ID, @"quantity" : allItems[key]}];
    }
    
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.jsonView.text = jsonString;
}

@end
