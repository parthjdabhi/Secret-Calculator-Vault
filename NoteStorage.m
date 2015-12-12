//
//  NoteStorage.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/15/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "NoteStorage.h"

@implementation NoteStorage

//Fetch all of the users notes
-(void)fetchNotes
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Notes"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    self.userNotes = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

//Create a new note
-(void)createNote:(NSString *)notes
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Notes *newNote = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:context];
    newNote.date = [NSDate date];
    
    //Set the title no bigger than 30 characters
    if(notes.length > 30){
        newNote.title = [notes substringToIndex:30];
    }
    else{
        newNote.title = notes;
    }
    newNote.notes = notes;
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

//Save a current note
-(void)saveNote:(NSString *)notes
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    self.selectedNote.date = [NSDate date];
    
    //Set the title no bigger than 30 characters
    if(notes.length > 30){
        self.selectedNote.title = [notes substringToIndex:30];
    }
    else{
        self.selectedNote.title = notes;
    }
    self.selectedNote.notes = notes;

    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

//Delete user contact from data base and remove from tableview
-(void)deleteNote:(long)index
{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:[self.userNotes objectAtIndex:index]];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    [self.userNotes removeObjectAtIndex:index];
}

//Set up NSManagedObject for CoreData related material
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
