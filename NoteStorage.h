//
//  NoteStorage.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/15/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Notes+CoreDataProperties.h"

@interface NoteStorage : NSObject

@property (strong, nonatomic) NSMutableArray *userNotes;
@property (strong, nonatomic) Notes *selectedNote;

-(void)createNote:(NSString *)notes;
-(void)fetchNotes;
-(void)deleteNote:(long)index;

@end
