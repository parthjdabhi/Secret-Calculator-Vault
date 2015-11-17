//
//  ViewPhotoVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 10/23/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "PhotoCVC.h"
#import "ViewPhotoVC.h"

@interface ViewPhotoVC () <UIScrollViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    // Do any additional setup after loading the view.
    NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto];
    UIImage *fullResImage = [UIImage imageWithData:imageData];
    self.displayImage.image = fullResImage;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(id)sender
{
    //Pass photo storage back to PhotoCVC
    PhotoCVC *destinationController = [[PhotoCVC alloc] init];
    destinationController.photoStorage = self.photoStorage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Previous photo
- (IBAction)backArrow:(id)sender
{
    long length = self.photoStorage.fullImageArray.count - 1;
    //If on the first photo, cycle current photo to the last
    if(self.photoStorage.currentPhoto == 0){
        self.photoStorage.currentPhoto = length;
        NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto];
        UIImage *fullResImage = [UIImage imageWithData:imageData];
        self.displayImage.image = fullResImage;
        NSLog(@"Back Arrow - current photo = %lu", self.photoStorage.currentPhoto);
    }
    else{
        NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto--];
        UIImage *fullResImage = [UIImage imageWithData:imageData];
        self.displayImage.image = fullResImage;
        NSLog(@"Back Arrow - current photo = %lu", self.photoStorage.currentPhoto);
    }
}

//Next photo
- (IBAction)forwardArrow:(id)sender
{
    long length = self.photoStorage.fullImageArray.count - 1;
    //If on the last photo, cycle current photo to the first
    if(self.photoStorage.currentPhoto == length){
        self.photoStorage.currentPhoto = 0;
        NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto];
        UIImage *fullResImage = [UIImage imageWithData:imageData];
        self.displayImage.image = fullResImage;
        NSLog(@"Front Arrow - current photo = %lu", self.photoStorage.currentPhoto);
    }
    else{
        NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto++];
        UIImage *fullResImage = [UIImage imageWithData:imageData];
        self.displayImage.image = fullResImage;
        NSLog(@"Frontsd Arrow - current photo = %lu", self.photoStorage.currentPhoto);
    }
}

//Fix and animate as well
- (IBAction)trashButton:(id)sender
{
    long length = self.photoStorage.fullImageArray.count;
    NSLog(@"current photo before removing = %lu", self.photoStorage.currentPhoto);
    //If user deletes last photo, dismiss modal back to collectionView
    if(self.photoStorage.currentPhoto == 0 && length == 1) {
        [self.photoStorage deletePhoto];
        [self.photoStorage.fullImageArray removeObjectAtIndex:self.photoStorage.currentPhoto];
        [self.photoStorage.scaledImageArray removeObjectAtIndex:self.photoStorage.currentPhoto];
        NSLog(@"current photo after removing = %lu", self.photoStorage.currentPhoto);
        PhotoCVC *destinationController = [[PhotoCVC alloc] init];
        destinationController.photoStorage = self.photoStorage;
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    //If user deletes first photo but theres still more photos, don't dismiss modal
    else if ((self.photoStorage.currentPhoto == 0) && (length > 0)){
        [self.photoStorage deletePhoto];
        [self.photoStorage.fullImageArray removeObjectAtIndex:self.photoStorage.currentPhoto];
        [self.photoStorage.scaledImageArray removeObjectAtIndex:self.photoStorage.currentPhoto];
        NSLog(@"current photo after removing = %lu", self.photoStorage.currentPhoto);
        NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto];
        UIImage *fullResImage = [UIImage imageWithData:imageData];
        self.displayImage.image = fullResImage;
    }
    //Delete selected photo and move current photo to the previous one
    else {
        [self.photoStorage deletePhoto];
        [self.photoStorage.fullImageArray removeObjectAtIndex:self.photoStorage.currentPhoto];
        [self.photoStorage.scaledImageArray removeObjectAtIndex:self.photoStorage.currentPhoto];
        self.photoStorage.currentPhoto--;
        NSLog(@"current photo after removing = %lu", self.photoStorage.currentPhoto);
        NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto];
        UIImage *fullResImage = [UIImage imageWithData:imageData];
        self.displayImage.image = fullResImage;
    }
}

//Action view
- (IBAction)actionButton:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *exportAction = [UIAlertAction actionWithTitle:@"Export Photo"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                  {
                                      NSData *imageData = [self.photoStorage.fullImageArray objectAtIndex:self.photoStorage.currentPhoto];
                                      UIImage *fullResImage = [UIImage imageWithData:imageData];
                                      UIImageWriteToSavedPhotosAlbum(fullResImage, nil, nil, nil);
                                  }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    
    [alert addAction:exportAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.displayImage;
}

@end
