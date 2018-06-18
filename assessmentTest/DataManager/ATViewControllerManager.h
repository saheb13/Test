//
//  ATViewControllerManager.h
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATViewControllerManager : NSObject

+ (instancetype)sharedManager;

- (void)chartData:(id)pParameter success:(void(^)(NSDictionary *dictionary))pSuccessCallback failure:(void(^)(NSError* error))pFailureCallback;
@end
