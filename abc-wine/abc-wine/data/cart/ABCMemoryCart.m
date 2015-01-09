//
//  ABCMemoryCart.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/9/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "ABCMemoryCart.h"

@interface ABCMemoryCart ()

@property (nonatomic, strong) NSMutableDictionary* items;

@end

@implementation ABCMemoryCart

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark ABCCart protocol

- (void)addProduct:(ABCProduct *)product quantity:(NSInteger)quantity{
    NSInteger current = [self.items[product] integerValue];
    NSInteger newValue = current + quantity;
    
    if(newValue > 0){
        self.items[product] = @(newValue);
    } else {
        [self.items removeObjectForKey:product];
    }
}

- (NSDictionary *)allProductsInCart{
    return self.items;
}


@end
