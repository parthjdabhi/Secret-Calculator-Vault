//
//  ContactStorage.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/15/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "ContactStorage.h"


@implementation ContactStorage

//Fetch users contact
-(void)fetchContacts
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]];
    self.userContacts = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

//Delete user contact from data base and remove from tableview
-(void)deleteContact:(long)index
{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:[self.userContacts objectAtIndex:index]];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    [self.userContacts removeObjectAtIndex:index];
}

//Create a new contact and add it to the CoreData database
-(void)createContact:(NSString *)firstName
            lastName:(NSString *)lastName
             company:(NSString *)company
        mobileNumber:(NSString *)mobileNumber
          homeNumber:(NSString *)homeNumber
          workNumber:(NSString *)workNumber
               email:(NSString *)email
               notes:(NSString *)notes
             website:(NSString *)website
{
    NSManagedObjectContext *context = [self managedObjectContext];
    //Create a new managed object
    Contacts *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
    newContact.date = [NSDate date];
    newContact.firstName = firstName;
    newContact.lastName = lastName;
    newContact.company = company;
    newContact.mobileNumber = mobileNumber;
    newContact.homeNumber = homeNumber;
    newContact.workNumber = workNumber;
    newContact.email = email;
    newContact.notes = notes;
    newContact.website = website;

    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

-(void)saveContact:(NSString *)firstName
            lastName:(NSString *)lastName
             company:(NSString *)company
        mobileNumber:(NSString *)mobileNumber
          homeNumber:(NSString *)homeNumber
          workNumber:(NSString *)workNumber
               email:(NSString *)email
               notes:(NSString *)notes
             website:(NSString *)website
{
    NSManagedObjectContext *context = [self managedObjectContext];

    self.selectedContact.date = [NSDate date];
    self.selectedContact.firstName = firstName;
    self.selectedContact.lastName = lastName;
    self.selectedContact.company = company;
    self.selectedContact.mobileNumber = mobileNumber;
    self.selectedContact.workNumber = workNumber;
    self.selectedContact.homeNumber = homeNumber;
    self.selectedContact.email = email;
    self.selectedContact.notes = notes;
    self.selectedContact.website = website;
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
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

-(NSMutableArray *)userContacts
{
    if(!_userContacts) _userContacts = [[NSMutableArray alloc] init];
    return _userContacts;
}

@end
