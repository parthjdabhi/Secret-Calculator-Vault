//
//  Album+CoreDataProperties.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/11/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Album.h"

NS_ASSUME_NONNULL_BEGIN

@interface Album (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSOrderedSet<Photo *> *photos;

@end

@interface Album (CoreDataGeneratedAccessors)

- (void)insertObject:(Photo *)value inPhotosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPhotosAtIndex:(NSUInteger)idx;
- (void)insertPhotos:(NSArray<Photo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePhotosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPhotosAtIndex:(NSUInteger)idx withObject:(Photo *)value;
- (void)replacePhotosAtIndexes:(NSIndexSet *)indexes withPhotos:(NSArray<Photo *> *)values;
- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSOrderedSet<Photo *> *)values;
- (void)removePhotos:(NSOrderedSet<Photo *> *)values;

@end

NS_ASSUME_NONNULL_END
