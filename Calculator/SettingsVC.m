//
//  SettingsVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/9/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "SettingsVC.h"
#import "Settings.h"
#import "CalculatorVC.h"
#import "NumericalVC.h"
#import "AlphabeticalVC.h"
#import "PatternVC.h"

@interface SettingsVC ()

@property (strong, nonatomic) Settings *settings;

@end

@implementation SettingsVC

-(Settings *)settings
{
    if(!_settings) _settings = [[Settings alloc] init];
    return _settings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lockButton:(id)sender
{
    if([self.settings.currentLock isEqualToString:@"alphabeticalLock"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AlphabeticalVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"alphabeticalLock"];
        viewController.lockVault = YES;
        [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if([self.settings.currentLock  isEqualToString:@"numericalLock"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NumericalVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"numericalLock"];
        viewController.lockVault = YES;
        [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if([self.settings.currentLock  isEqualToString:@"patternLock"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PatternVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"patternlLock"];
        viewController.lockVault = YES;
        [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if([self.settings.currentLock  isEqualToString:@"calculatorLock"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CalculatorVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"CalculatorLock"];
        viewController.lockVault = YES;
        [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if ([self.settings.currentLock  isEqualToString:@"None"]) {
        //Tell user he/she needs to select a lock first
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
