//
//  AlphabeticalVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/25/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "AlphabeticalVC.h"
#import "Settings.h"
#import <AudioToolbox/AudioToolbox.h>


@interface AlphabeticalVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextfield;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) Settings *settings;

@end

static int createPasswordCount = 0;

@implementation AlphabeticalVC

-(Settings *)settings
{
    if(!_settings) _settings = [[Settings alloc] init];
    return _settings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.changeLock){
        [self.settings resetUserPassword];
    }
    
    [self.settings retrievePassword];
    if(self.settings.isPasswordCreated){
        self.instructionLabel.text = @"Enter Passcode";
    }
    else{
        self.instructionLabel.text = @"Create Passcode";
        createPasswordCount = 0;
    }
    
    self.inputTextfield.delegate = self;
    [self.inputTextfield becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.settings.isPasswordCreated && [self.settings unlockVault:self.inputTextfield.text]){
        if(self.changeLock){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [self performSegueWithIdentifier:@"UnlockAlphabeticalVault" sender:self];
        }
    }
    
    else if(!self.settings.isPasswordCreated){
        [self.settings createUserPassword:self.inputTextfield.text];
        if (createPasswordCount == 0){
            self.instructionLabel.text = @"Confirm Passcord";
            self.inputTextfield.text = @"";
            createPasswordCount++;
        }
        else if (createPasswordCount == 1 && self.settings.isPasswordCreated){
            createPasswordCount++;
            NSLog(@"Segue! password created");
            if(self.changeLock){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
            [self performSegueWithIdentifier:@"UnlockAlphabeticalVault" sender:self];
            }
        }
        else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            NSLog(@"Incorrect");
            self.instructionLabel.text = @"Create Passcode";
            createPasswordCount = 0;
            self.inputTextfield.text = @"";
            self.settings.isPasswordCreated = NO;
            self.settings.userPassword = nil;
        }
    }
    return NO;
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
