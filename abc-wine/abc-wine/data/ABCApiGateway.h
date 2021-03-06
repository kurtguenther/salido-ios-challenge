//
//  ABCApiGateway.h
//  abc-wine
//
//  Created by Kurt Guenther on 1/8/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


/**
 *  Brokers all the data between the Server and the application
 *  Consumers should use the shareInstance Singleton
 */
@interface ABCApiGateway : NSObject

+(instancetype)sharedInstance;

- (void) fetchProductsWithOffset:(NSInteger)offset
                           limit:(NSInteger)limit
                         success:(void (^)(NSArray* products))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
