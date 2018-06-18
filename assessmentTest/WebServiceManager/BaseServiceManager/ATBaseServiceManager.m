//
//  ATBaseServiceManager.m
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import "ATBaseServiceManager.h"

@implementation ATBaseServiceManager

- (void)communicateUsingGETMethod:(NSString *)pBaseURL parameterDictionary:(id)pParameterDictionary success:(void (^)(id))pSuccessCallback failure:(void (^)(NSError *))pFailiureCallback {
    NSURL *url = [NSURL URLWithString:pBaseURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            pSuccessCallback (data);
        } else {
            pFailiureCallback (error);
        }
    }];
    
    [task resume];
}
@end
