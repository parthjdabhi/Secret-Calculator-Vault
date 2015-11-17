//
//  AddContactVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 9/19/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactStorage.h"
#import "Contacts+CoreDataProperties.h"

@interface AddContactVC : UIViewController

@property (strong, nonatomic) ContactStorage *contactStorage;

@end
