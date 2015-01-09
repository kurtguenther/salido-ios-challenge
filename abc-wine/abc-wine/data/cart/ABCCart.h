//
//  ABCCart.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABCProduct.h"

@protocol ABCCart <NSObject>

/**
 *  Returns all of the items currently in the cart
 *
 *  @return an NSDictionary mapping ABCProduct -> the quantity of the item
 */
- (NSDictionary*) allProductsInCart;

/**
 *  Changes the quantity of an item in the cart.
 *  The quantity passed is a delta (positive or negative) that will be added to the existing quantity of item (should it exist)
 *  If the resulting quantity is < 1 the product is dropped from the cart.
 *
 *  @param product  the ABCProduct to add
 *  @param quantity the change in quantity, can be positive or negative, integers only
 */
- (void) addProduct:(ABCProduct*)product quantity:(NSInteger)quantity;

@end
