//
//  ATViewControllerManager.m
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import "ATViewControllerManager.h"
#import "ATWebaccessManager.h"

@implementation ATViewControllerManager

+ (instancetype)sharedManager {
    static ATViewControllerManager *managerInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerInstance = [[ATViewControllerManager alloc] init];
    });
    return managerInstance;
}

- (void)chartData:(id)pParameter success:(void (^)(NSDictionary *dictionary))pSuccessCallback failure:(void (^)(NSError * error))pFailureCallback {
    [[ATWebaccessManager sharedManager] invokeGetChartData:pParameter success:^(NSData *successData) {
        __block NSDictionary *successDictionary;
        successDictionary = [self handleSuccessReponse:successData];
        pSuccessCallback(successDictionary);
        
    } failure:^(NSError *error) {
        pFailureCallback(error);
    }];
}

- (NSDictionary*)handleSuccessReponse:(NSData*)pData {
    __block NSDictionary *successDictionary;
    // NSdata into JSON.
    [self serializeJSON:pData success:^(NSDictionary *JSONDictionary) {
        successDictionary = JSONDictionary;
    } failure:^(NSError *error) {
        // Print error
        NSLog(@"Parse Error");
    }];
    return successDictionary;
}

#pragma mark - Common Util method
#warning Put this method in common util

- (void)serializeJSON:(NSData*)pData success:(void(^)(NSDictionary* JSONDictionary))pSuucess failure:(void(^)(NSError *error))pFailure {
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:pData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        pFailure(error);
    } else {
        pSuucess(jsonDictionary);
    }
}
@end
