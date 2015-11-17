//
//  PasswordTVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 9/23/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordStorage.h"
#import "Passwords+CoreDataProperties.h"

@interface PasswordTVC : UITableViewController

@property (strong, nonatomic) PasswordStorage *passwordStorage;

@end
