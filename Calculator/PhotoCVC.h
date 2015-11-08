//
//  PhotoCVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 10/13/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album+CoreDataProperties.h"
#import "Photo+CoreDataProperties.h"

@interface PhotoCVC : UICollectionViewController

@property (strong) Album *userAlbum;
@property (strong, nonatomic) NSMutableArray *userPhotos;

-(UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;

@end
