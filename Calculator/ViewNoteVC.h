//
//  ViewNoteVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 10/5/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notes+CoreDataProperties.h"

@interface ViewNoteVC : UIViewController

@property (strong) NSManagedObject *note;

@end
