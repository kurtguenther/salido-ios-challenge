//
//  ABCApiGateway.m
//  abc-wine
//
//  Created by Kurt Guenther on 1/8/15.
//  Copyright (c) 2015 Salido. All rights reserved.
//

#import "ABCApiGateway.h"
#import "ABCProduct.h"


#define API_BASE_URL @"http://services.wine.com/api/beta2/service.svc/json"
#define API_KEY @"0d01cf1d381ddfa1bef92e10e81319c9"

@implementation ABCApiGateway

+(instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (NSDictionary*) addCommonRequestParameters:(NSDictionary*)params {
    NSMutableDictionary* newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [newParams setObject:API_KEY forKey:@"apikey"];
    return newParams;
}

- (void) fetchProductsWithOffset:(NSInteger)offset
                           limit:(NSInteger)limit
                         success:(void (^)(NSArray* products))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary* params = @{@"offset": @(offset),
                             @"size": @(limit)};
    NSString* requestUrl = [NSString stringWithFormat:@"%@%@", API_BASE_URL, @"/catalog"];
    [manager GET:requestUrl parameters:[self addCommonRequestParameters:params] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* resp = responseObject;
        NSMutableArray* retVal = [NSMutableArray array];
        
        //We have not guaranteed success yet.
        //If the return code is anything but 0 an error has happened
        //Side note: who uses 200 as a bad response value!?!
        NSInteger returnCode = [resp[@"Status"][@"ReturnCode"] integerValue];
        if(returnCode == 0){
            for(NSDictionary* item in resp[@"Products"][@"List"]){
                ABCProduct* product = [[ABCProduct alloc] init];
                product.ID = [NSString stringWithFormat:@"%ld", (long) [item[@"Id"] integerValue]];
                product.name = item[@"Name"];
                [retVal addObject:product];
            }
            
            if(success){
                success(retVal);
            }
        } else {
            NSArray* messages = resp[@"Status"][@"Messages"];
            NSLog(@"API response error (%ld): %@", (long)returnCode, [messages firstObject]);
            if(failure){
                NSError* err = [NSError errorWithDomain:[messages firstObject] code:returnCode userInfo:@{@"messages":messages}];
                failure(operation, err);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"API failed, error (%ld): %@", [error code], [error localizedDescription]);
        if(failure){
            failure(operation, error);
        }
    }];
}

@end
