//
//  PhotoStorage.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/10/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "PhotoStorage.h"

@implementation PhotoStorage

//Fetch the users saved albums
-(void)fetchAlbums
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    self.userAlbums = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

//Fetch the users saved photos from selected album
-(void)fetchPhotos
{
    self.currentPhoto = -1;
    self.scaledImageArray = nil;
    self.fullImageArray = nil;
    for (Photo *photo in self.selectedAlbum.photos){
        UIImage *image = [UIImage imageWithData:photo.thumbnail];
        [self.fullImageArray addObject:photo.image];
        [self.scaledImageArray addObject:image];
        self.currentPhoto++;
    }
}

//Delete current displayed photo
-(void)deletePhoto
{
    NSManagedObjectContext *context = [self managedObjectContext];
    [self.selectedAlbum removeObjectFromPhotosAtIndex:self.currentPhoto];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}

//Add selected photo to selected album
-(void)addPhotoToAlbum:(UIImage *)image
{
    NSManagedObjectContext *context = [self managedObjectContext];

    UIImage *scaleImage = [self imageWithImage:image scaledToFillSize:CGSizeMake(64,64)];
    
    NSData *fullImage = UIImageJPEGRepresentation(image, 1.0);
    NSData *scaledImage = UIImageJPEGRepresentation(scaleImage, 1.0);
    
    Photo *addPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    addPhoto.date = [NSDate date];
    addPhoto.image = fullImage;
    addPhoto.thumbnail = scaledImage;
    
    [self.fullImageArray addObject:fullImage];
    [self.scaledImageArray addObject:scaleImage];
    
    [self.selectedAlbum addPhotosObject:addPhoto];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

//Create a new album and save it
-(void)createNewAlbum:(NSString *)title
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    
    album.title = title;
    album.date = [NSDate date];
    [self.userAlbums addObject:album];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

//To scale down the images for UICollectionView to display #performanceissues
-(UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//Set up NSManagedObject for fetching
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(NSMutableArray *)fullImageArray
{
    if(!_fullImageArray) _fullImageArray = [[NSMutableArray alloc] init];
        return _fullImageArray;
}

-(NSMutableArray *) scaledImageArray
{
    if(!_scaledImageArray) _scaledImageArray = [[NSMutableArray alloc] init];
        return _scaledImageArray;
}

@end
