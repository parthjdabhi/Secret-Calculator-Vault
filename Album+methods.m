//
//  Album+methods.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/11/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "Album+methods.h"

@implementation Album (methods)

//CoreData has a bug when checking "Ordered" in your data model. It crashed my program when adding a photo object to an album.
//Below is the workaround solution
- (void)addPhotosObject:(Photo *)value
{
    NSMutableOrderedSet *photos = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.photos];
    [photos addObject:value];
    self.photos = photos;
}

- (void)removePhotosObject:(Photo *)value
{
    NSMutableOrderedSet *photos = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.photos];
    [photos removeObject:value];
    self.photos = photos;
}

- (void)removeObjectFromPhotosAtIndex:(NSUInteger)idx
{
    NSMutableOrderedSet *photos = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.photos];
    [photos removeObjectAtIndex:idx];
    self.photos = photos;
}


@end
