//
//  PhotoCVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 10/13/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "PhotoCVC.h"
#import "PhotoCVCell.h"
#import "ViewPhotoVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoCVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *thumbnailArray;
@property (strong, nonatomic) NSMutableArray *fullResolutionImageArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotoCVC

@synthesize collectionView = _collectionView;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.delegate = self;
    
    for (Photo *photo in self.userAlbum.photos){
        UIImage *image = [UIImage imageWithData:photo.thumbnail];
        [self.fullResolutionImageArray addObject:photo.image];
        [self.thumbnailArray addObject:image];
    }
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(100, 100);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    
    [self.collectionView reloadData];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Take photo from users camera
- (void)takePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

//Choose photo from users photo library
- (void)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)addPhotoButton:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Take Photo"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        [self takePhoto];
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Choose Existing Photo"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        [self selectPhoto];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {
        
    }];
    [alert addAction:cancelAction];
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//Save photo that the user selected
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    //Scale the image down for obvious performance reasons
    UIImage *scaleImage = [self imageWithImage:chosenImage scaledToFillSize:CGSizeMake(64, 64)];
    NSData *fullImage = UIImageJPEGRepresentation(chosenImage, 1.0);
    NSData *scaledImage = UIImageJPEGRepresentation(scaleImage, 0.1);
    
    Photo *addPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    addPhoto.date = [NSDate date];
    addPhoto.image = fullImage;
    addPhoto.thumbnail = scaledImage;
    
    [self.fullResolutionImageArray addObject:fullImage];
    [self.thumbnailArray addObject:scaleImage];
    [self.userAlbum addPhotosObject:addPhoto];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.thumbnailArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    //Configure the cell
    UIImageView *photoImageView = (UIImageView *)[cell viewWithTag:100];
    photoImageView.image = self.thumbnailArray [indexPath.row];
    
    return cell;
}

//The next few methods minimize spacing between photos to create a mighty fine look
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.00001;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}

//Set up NSManagedObject for fetching-saving
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(NSMutableArray *)thumbnailArray
{
    if(!_thumbnailArray) _thumbnailArray = [[NSMutableArray alloc] init];
    return _thumbnailArray;
}

-(NSMutableArray *)fullResolutionImageArray
{
    if(!_fullResolutionImageArray) _fullResolutionImageArray = [[NSMutableArray alloc] init];
    return _fullResolutionImageArray;
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

 #pragma mark - Navigation
 
//Pass NSManagedObject through viewControllers to view users selected phone
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"toViewPhoto"]){
        NSIndexPath *index = [self.collectionView indexPathForCell:sender];
        NSData *image = [self.fullResolutionImageArray objectAtIndex:index.row];
        UINavigationController *nav = [segue destinationViewController];
        ViewPhotoVC *destViewController = (ViewPhotoVC *)nav.topViewController;
        destViewController.selectedImage = image;
    }
}

@end
