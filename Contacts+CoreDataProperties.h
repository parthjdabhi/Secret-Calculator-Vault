//
//  Contacts+CoreDataProperties.h
//  Calculator
//
//  Created by Corey Allen Pett on 10/1/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contacts.h"

NS_ASSUME_NONNULL_BEGIN

@interface Contacts (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *company;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *homeNumber;
@property (nullable, nonatomic, retain) NSString *mobileNumber;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSString *website;
@property (nullable, nonatomic, retain) NSString *workNumber;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;

@end

NS_ASSUME_NONNULL_END
