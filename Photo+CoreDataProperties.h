//
//  Photo+CoreDataProperties.h
//  Calculator
//
//  Created by Corey Allen Pett on 10/31/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSData *thumbnail;
@property (nullable, nonatomic, retain) Album *albumBook;

@end

NS_ASSUME_NONNULL_END
