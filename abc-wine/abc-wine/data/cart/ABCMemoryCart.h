//
//  ABCMemoryCart.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABCCart.h"

/**
 *  A simple In Memory representation of the Cart
 *  Only persists as long as the application is running
 */
@interface ABCMemoryCart : NSObject <ABCCart>

@end
