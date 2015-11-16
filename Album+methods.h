//
//  Album+methods.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/11/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "Album.h"

@interface Album (methods)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)removeObjectFromPhotosAtIndex:(NSUInteger)idx;


@end

