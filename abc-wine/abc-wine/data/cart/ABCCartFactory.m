//
//  ABCCartFactory.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "ABCCartFactory.h"
#import "ABCMemoryCart.h"

@implementation ABCCartFactory

+ (id<ABCCart>)defaultCart{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        //We can provide a concrete implementation via config
        //like from the plist, but I ran out of steam to do this
        sharedInstance = [[ABCMemoryCart alloc] init];
    });
    return sharedInstance;

}

@end
