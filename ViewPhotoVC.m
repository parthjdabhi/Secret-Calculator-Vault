//
//  ViewPhotoVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 10/23/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "ViewPhotoVC.h"

@interface ViewPhotoVC () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    // Do any additional setup after loading the view.
    UIImage *fullResImage = [UIImage imageWithData:self.selectedImage];
    self.displayImage.image = fullResImage;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //[self.tabBarController.tabBar setHidden:YES];
    [self.navigationController setToolbarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    //[self.tabBarController.tabBar setHidden:NO];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionButton:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Export Photo"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                  {
                                      UIImage *fullResImage = [UIImage imageWithData:self.selectedImage];
                                      UIImageWriteToSavedPhotosAlbum(fullResImage, nil, nil, nil);
                                  }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    
    [alert addAction:firstAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.displayImage;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//-(UIImage *)selectedImage
//{
//    if(!_selectedImage) _selectedImage = [[UIImage alloc] init];
//    return _selectedImage;
//}

@end
