//
//  ContactStorage.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/15/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Contacts+CoreDataProperties.h"

@interface ContactStorage : NSObject

@property (strong, nonatomic) NSMutableArray *userContacts;
@property (strong, nonatomic) Contacts *selectedContact;

-(void)fetchContacts;
-(void)deleteContact:(long)index;
-(void)createContact:(NSString *)firstName
          lastName:(NSString *)lastName
           company:(NSString *)company
      mobileNumber:(NSString *)mobileNumber
        homeNumber:(NSString *)homeNumber
        workNumber:(NSString *)workNumber
             email:(NSString *)email
             notes:(NSString *)notes
           website:(NSString *)website;

@end
