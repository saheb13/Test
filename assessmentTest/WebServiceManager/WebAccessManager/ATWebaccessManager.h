//
//  ATWebaccessManager.h
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATWebaccessManager : NSObject
+ (instancetype)sharedManager;
- (void)invokeGetChartData:(id)pParameter success:(void(^)(NSData* successData))pSuccessCallback failure:(void(^)(NSError* error))pFailureCallback;
@end
