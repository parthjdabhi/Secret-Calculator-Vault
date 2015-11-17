//
//  EditContactVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 9/18/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactStorage.h"
#import "Contacts+CoreDataProperties.h"

@interface ViewContactVC : UIViewController

@property (strong, nonatomic) ContactStorage *contactStorage;

@end
