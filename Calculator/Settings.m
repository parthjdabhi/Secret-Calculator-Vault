//
//  Settings.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/19/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "Settings.h"

@implementation Settings

//Create user password
-(void)createUserPassword:(NSString *)input
{
    //Set user password
    if (!self.userPassword) {
        self.userPassword = input;
    }
    //Confirm user password
    else if (self.userPassword){
        if([self.userPassword isEqualToString:input]) {
            self.isPasswordCreated = YES;
            [[NSUserDefaults standardUserDefaults]setValue:self.userPassword forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

-(void)resetUserPassword
{
    self.isPasswordCreated = NO;
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//Allow access to the users vault
-(BOOL)unlockVault:(NSString *)input
{
    if([self.userPassword isEqualToString:input]){
        return YES;
    }
    else{
        return NO;
    }
}

//Check if password is set and retrieve it
-(void)retrievePassword
{
    self.userPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    if(!self.userPassword) {
        self.isPasswordCreated = NO;
    }
    else {
        self.isPasswordCreated = YES;
    }
}

//Check was lock is selected
-(void)retrieveCurrentLock
{
    self.currentLock = [[NSUserDefaults standardUserDefaults] stringForKey:@"currentLock"];
    if(!self.currentLock){
        self.currentLock = @"calculatorLock";
        [[NSUserDefaults standardUserDefaults]setValue:self.currentLock forKey:@"currentLock"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//Set lock based on users selection in settings
-(void)setLock:(NSString *)lockType
{
    if([lockType isEqualToString:@"alphabeticalButton"]){
        self.currentLock = @"alphabeticalLock";
    }
    if([lockType isEqualToString:@"numericalButton"]){
        self.currentLock = @"numericalLock";
    }
    if([lockType isEqualToString:@"patternButton"]){
        self.currentLock = @"patternLock";
    }
    if([lockType isEqualToString:@"calculatorButton"]){
        self.currentLock = @"calculatorLock";
    }
    if ([lockType isEqualToString:@"noneButton"]) {
        self.currentLock = @"none";
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:self.currentLock forKey:@"currentLock"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
