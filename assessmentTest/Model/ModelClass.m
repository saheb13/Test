//
//  BaseClass.m
//
//  Created by saheba juneja on 18/06/18
//  Copyright (c) 2018 Codeeks. All rights reserved.
//

#import "ModelClass.h"
#import "Graph.h"


NSString *const kBaseClassGraph = @"graph";


@interface ModelClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelClass

@synthesize graph = _graph;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedGraph = [dict objectForKey:kBaseClassGraph];
    NSMutableArray *parsedGraph = [NSMutableArray array];
    
    if ([receivedGraph isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGraph) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGraph addObject:[Graph modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGraph isKindOfClass:[NSDictionary class]]) {
       [parsedGraph addObject:[Graph modelObjectWithDictionary:(NSDictionary *)receivedGraph]];
    }

    self.graph = [NSArray arrayWithArray:parsedGraph];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForGraph = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.graph) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGraph addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGraph addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGraph] forKey:kBaseClassGraph];

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

    self.graph = [aDecoder decodeObjectForKey:kBaseClassGraph];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_graph forKey:kBaseClassGraph];
}

- (id)copyWithZone:(NSZone *)zone {
    ModelClass *copy = [[ModelClass alloc] init];
    
    
    
    if (copy) {

        copy.graph = [self.graph copyWithZone:zone];
    }
    
    return copy;
}


@end
