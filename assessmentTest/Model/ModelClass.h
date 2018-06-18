//
//  BaseClass.h
//
//  Created by saheba juneja on 18/06/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *graph;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
