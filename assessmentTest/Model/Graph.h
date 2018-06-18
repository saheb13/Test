//
//  Graph.h
//
//  Created by saheba juneja on 18/06/18
//  Copyright (c) 2018 Codeeks. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Graph : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double index;
@property (nonatomic, assign) double value;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
