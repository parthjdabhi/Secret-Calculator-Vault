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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotoCVC

@synthesize collectionView = _collectionView;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.delegate = self;
    
    [self.photoStorage fetchPhotos];
    
    [self.collectionView reloadData];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.collectionView reloadData];
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

//Action view
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
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.photoStorage addPhotoToAlbum:chosenImage];
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
    return self.photoStorage.scaledImageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    //Configure the cell
    UIImageView *photoImageView = (UIImageView *)[cell viewWithTag:100];
    photoImageView.image = self.photoStorage.scaledImageArray [indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.photoStorage.currentPhoto = indexPath.row;
    NSLog(@"Current Photo to check for array = %lu", self.photoStorage.currentPhoto);
}

//The next three methods minimize spacing between photos to create a mighty fine look
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.00001;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}

 #pragma mark - Navigation
 
//Pass NSManagedObject through viewControllers to view users selected phone
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"toViewPhoto"]){
        UINavigationController *nav = [segue destinationViewController];
        ViewPhotoVC *destViewController = (ViewPhotoVC *)nav.topViewController;
        destViewController.photoStorage = self.photoStorage;
    }
}

@end
