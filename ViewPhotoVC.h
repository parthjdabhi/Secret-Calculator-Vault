//
//  ViewPhotoVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 10/23/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album+CoreDataProperties.h"
#import "Photo+CoreDataProperties.h"

@interface ViewPhotoVC : UIViewController

@property (strong, nonatomic) NSData *selectedImage;
//@property (strong) NSManagedObject *selectedPhoto;

@end
