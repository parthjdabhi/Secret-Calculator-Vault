//
//  Notes.h
//  Calculator
//
//  Created by Corey Allen Pett on 9/23/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notes : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * notes;

@end
