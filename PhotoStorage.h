//
//  PhotoStorage.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/10/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Album+CoreDataProperties.h"
#import "Photo+CoreDataProperties.h"

@interface PhotoStorage : NSObject

@property (strong, nonatomic) NSMutableArray *userAlbums;
@property (strong, nonatomic) NSMutableArray *scaledImageArray;
@property (strong, nonatomic) NSMutableArray *fullImageArray;
@property (strong, nonatomic) Album *selectedAlbum;
@property (strong, nonatomic) Photo *selectedPhoto;
@property (nonatomic) long currentPhoto;

-(void)deleteAlbum:(long)index;
-(void)deletePhoto;
-(void)fetchPhotos;
-(void)fetchAlbums;
-(void)addPhotoToAlbum:(UIImage *)image;
-(void)createNewAlbum:(NSString *)title;

@end
