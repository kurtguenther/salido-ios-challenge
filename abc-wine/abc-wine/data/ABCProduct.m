//
//  Product.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/7/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "ABCProduct.h"

@implementation ABCProduct

- (id)copyWithZone:(NSZone *)zone{
    ABCProduct* copy = [[[self class] alloc] init];
    
    if (copy) {
        copy.ID = self.ID;
        copy.name = self.name;
    }
    
    return copy;
}

- (BOOL)isEqual:(id)object{
    return [self.ID isEqualToString:[object ID]];
}

- (NSUInteger)hash{
    return [self.ID hash];
}

@end
