//
//  NSArray+FlattenTest.m
//  DemoAssignment4
//
//  Created by Shailendra Kumar on 12/04/16.
//  Copyright © 2016 Appideas Sofware Solutions. All rights reserved.
//

#import "NSArray+FlattenTest.h"

@implementation NSArray (FlattenTest)

//for convert flatten an array of arbitrarily nested arrays of integers into a flat array of integers

-(NSArray *) flattened {
    NSMutableArray *flattened = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for (id object in self) {
        if ([object isKindOfClass:[NSArray class]])
            [flattened addObjectsFromArray:((NSArray *)object).flattened];
        else
            [flattened addObject:object];
    }
    
    return flattened ;
}

//////////////////////
@end
