//
//  ATBaseServiceManager.h
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATBaseServiceManager : NSObject

- (void)communicateUsingGETMethod:(NSString*)pBaseURL parameterDictionary:(id)pParameterDictionary success:(void(^)(id successResponse))pSuccessCallback failure:(void(^)(NSError* error))pFailiureCallback;

@end
