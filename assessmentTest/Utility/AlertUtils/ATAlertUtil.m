//
//  ATAlertUtil.m
//  assessmentTest
//
//  Created by saheba juneja on 18/06/18.
//  Copyright © 2018 saheba juneja. All rights reserved.
//

#import "ATAlertUtil.h"

@implementation ATAlertUtil
+(void)showMessage:(NSString *)message from:(id)viewController {
    UIAlertController *alert = [self alertInstanse:@"" message:message];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    [alert addAction:okAction];
    
    [viewController presentViewController:alert animated:YES completion:nil];
    
}

+ (UIAlertController *)alertInstanse:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alert = nil;
    
    if ( (title.length > 0) && (message.length > 0) ) {
        alert = [UIAlertController alertControllerWithTitle:title
                                                    message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
    } else if (message.length) {
        alert = [UIAlertController alertControllerWithTitle:@""
                                                    message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
    }
    
    return alert;
}
@end
