//
//  ATWebaccessManager.m
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import "ATWebaccessManager.h"
#import "ATBaseServiceManager.h"

@interface ATWebaccessManager () {
}

@end

@implementation ATWebaccessManager

+ (instancetype)sharedManager {
    static ATWebaccessManager *managerInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        managerInstance = [[ATWebaccessManager alloc] init];
    });
    
    return managerInstance;
}

- (void)invokeGetChartData:(id)pParameter success:(void (^)(NSData *))pSuccessCallback failure:(void (^)(NSError *))pFailureCallback {
    // Form URL here
    NSString *baseURL = @"https://api.myjson.com/bins/ipz6h";
    // Initial session configuration
    ATBaseServiceManager *baseServiceManager = [[ATBaseServiceManager alloc] init];
    // Call Get/ Post
    [baseServiceManager communicateUsingGETMethod:baseURL parameterDictionary:pParameter success:^(id successResponse) {
        pSuccessCallback(successResponse);
        
    } failure:^(NSError *error) {
        pFailureCallback(error);
    }];
}

@end
