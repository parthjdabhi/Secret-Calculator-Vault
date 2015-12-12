//
//  SecurityVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/19/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "SecurityVC.h"
#import "CalculatorVC.h"
#import "NumericalVC.h"
#import "AlphabeticalVC.h"
#import "PatternVC.h"

@interface SecurityVC ()

@property (strong, nonatomic) Settings *userSettings;
@property (weak, nonatomic) IBOutlet UISwitch *breakInSwitch;

@property (weak, nonatomic) IBOutlet UIImageView *alphabeticalCheck;
@property (weak, nonatomic) IBOutlet UIImageView *numericalCheck;
@property (weak, nonatomic) IBOutlet UIImageView *patternCheck;
@property (weak, nonatomic) IBOutlet UIImageView *calculatorCheck;
@property (weak, nonatomic) IBOutlet UIImageView *noneCheck;

@end

@implementation SecurityVC

-(Settings *)userSettings
{
    if(!_userSettings) _userSettings = [[Settings alloc] init];
    return _userSettings;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.userSettings retrieveCurrentLock];
    NSLog(@"currentLock = %@", self.userSettings.currentLock);
    [self setCheckmark];
    
}

-(void)setCheckmark
{
    NSLog(@"currentLock = %@", self.userSettings.currentLock);
    if([self.userSettings.currentLock isEqualToString:@"alphabeticalLock"]){
        self.alphabeticalCheck.hidden = NO;
        self.numericalCheck.hidden = YES;
        self.patternCheck.hidden = YES;
        self.calculatorCheck.hidden = YES;
        self.noneCheck.hidden = YES;
    }
    if([self.userSettings.currentLock isEqualToString:@"numericalLock"]){
        self.alphabeticalCheck.hidden = YES;
        self.numericalCheck.hidden = NO;
        self.patternCheck.hidden = YES;
        self.calculatorCheck.hidden = YES;
        self.noneCheck.hidden = YES;
    }
    if([self.userSettings.currentLock isEqualToString:@"patternLock"]){
        self.alphabeticalCheck.hidden = YES;;
        self.numericalCheck.hidden = YES;
        self.patternCheck.hidden = NO;
        self.calculatorCheck.hidden = YES;
        self.noneCheck.hidden = YES;
    }
    if([self.userSettings.currentLock isEqualToString:@"calculatorLock"]){
        self.alphabeticalCheck.hidden = YES;
        self.numericalCheck.hidden = YES;
        self.patternCheck.hidden = YES;
        self.calculatorCheck.hidden = NO;
        self.noneCheck.hidden = YES;
    }
    if ([self.userSettings.currentLock isEqualToString:@"none"]) {
        self.alphabeticalCheck.hidden = YES;
        self.numericalCheck.hidden = YES;
        self.patternCheck.hidden = YES;
        self.calculatorCheck.hidden = YES;
        self.noneCheck.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alphabeticalButton:(id)sender
{
    [self.userSettings setLock:@"alphabeticalButton"];
    [self setCheckmark];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlphabeticalVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"alphabeticalLock"];
    viewController.changeLock = YES;
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)numericalButton:(id)sender
{
    [self.userSettings setLock:@"numericalButton"];
    [self setCheckmark];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NumericalVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"numericalLock"];
    viewController.changeLock = YES;
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)patternButton:(id)sender
{
//    [self.userSettings setLock:@"patternButton"];
//    [self setCheckmark];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PatternVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"patternLock"];
//    viewController.changeLock = YES;
//    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
//    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)calculatorButton:(id)sender
{
    [self.userSettings setLock:@"calculatorButton"];
    [self setCheckmark];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CalculatorVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"calculatorLock"];
    viewController.changeLock = YES;
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)noneButton:(id)sender
{
    [self.userSettings setLock:@"noneButton"];
    [self setCheckmark];
}

- (IBAction)changePasswordButton:(id)sender
{
    if([self.userSettings.currentLock isEqualToString:@"alphabeticalLock"]){
        AlphabeticalVC *viewController = [[AlphabeticalVC alloc] init];
        viewController.changeLock = YES;
        self.userSettings.isPasswordCreated = NO;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if([self.userSettings.currentLock  isEqualToString:@"numericalLock"]){
        NumericalVC *viewController = [[NumericalVC alloc] init];
        viewController.changeLock = YES;
        self.userSettings.isPasswordCreated = NO;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if([self.userSettings.currentLock  isEqualToString:@"patternLock"]){
        PatternVC *viewController = [[PatternVC alloc] init];
        viewController.changeLock = YES;
        self.userSettings.isPasswordCreated = NO;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if([self.userSettings.currentLock  isEqualToString:@"calculatorLock"]){
        CalculatorVC *viewController = [[CalculatorVC alloc] init];
        viewController.changeLock = YES;
        self.userSettings.isPasswordCreated = NO;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if ([self.userSettings.currentLock  isEqualToString:@"none"]) {
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
