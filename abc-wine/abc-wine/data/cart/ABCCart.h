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

- (NSDictionary*) allProductsInCart;
- (void) addProduct:(ABCProduct*)product quantity:(NSInteger)quantity;

@end
