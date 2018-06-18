//
//  Graph.m
//
//  Created by saheba juneja on 18/06/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Graph.h"


NSString *const kGraphIndex = @"index";
NSString *const kGraphValue = @"value";


@interface Graph ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Graph

@synthesize index = _index;
@synthesize value = _value;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.index = [[self objectOrNilForKey:kGraphIndex fromDictionary:dict] doubleValue];
            self.value = [[self objectOrNilForKey:kGraphValue fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.index] forKey:kGraphIndex];
    [mutableDict setValue:[NSNumber numberWithDouble:self.value] forKey:kGraphValue];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.index = [aDecoder decodeDoubleForKey:kGraphIndex];
    self.value = [aDecoder decodeDoubleForKey:kGraphValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_index forKey:kGraphIndex];
    [aCoder encodeDouble:_value forKey:kGraphValue];
}

- (id)copyWithZone:(NSZone *)zone {
    Graph *copy = [[Graph alloc] init];
    
    
    
    if (copy) {

        copy.index = self.index;
        copy.value = self.value;
    }
    
    return copy;
}


@end
