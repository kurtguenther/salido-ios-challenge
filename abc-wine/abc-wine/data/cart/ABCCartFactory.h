//
//  ABCCartFactory.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABCCart.h"

/**
 *  Returns the cart for the application
 *  Consumers should not instantiate concrete carts themselves
 *  But consume them from this Singleton
 */
@interface ABCCartFactory : NSObject

+(id<ABCCart>)defaultCart;

@end
