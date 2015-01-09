//
//  Product.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/7/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ABCProduct : NSObject<NSCopying>

@property (nonatomic, strong) NSString* ID;
@property (nonatomic, strong) NSString* name;

@end
