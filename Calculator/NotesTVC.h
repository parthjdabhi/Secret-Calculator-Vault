//
//  NotesTVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 9/23/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteStorage.h"
#import "Notes+CoreDataProperties.h"

@interface NotesTVC : UITableViewController

@property (strong, nonatomic) NoteStorage *noteStorage;
@property (strong, nonatomic) NSArray *searchResults;

@end
