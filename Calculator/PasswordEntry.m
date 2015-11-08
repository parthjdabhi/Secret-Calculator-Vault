//
//  PasswordEntry.m
//  Calculator
//
//  Created by Corey Allen Pett on 8/31/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "PasswordEntry.h"

@implementation PasswordEntry


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

-(void)createUserPassword
{
    if (!self.userPassword) {
        self.userPassword = self.calculator.outputAsString;
        NSLog(@"userPassword = %@", self.userPassword);
        self.calculator.calculationStringOne = nil;
        self.calculator.calculationStringTwo = nil;
        self.calculator.outputAsString = nil;
    }
    else if (self.userPassword){
        NSLog(@"outputstring = %@", self.calculator.outputAsString);
        if([self.userPassword isEqualToString:self.calculator.outputAsString]) {
            self.isPasswordCreated = YES;
            [[NSUserDefaults standardUserDefaults]setValue:self.userPassword forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.calculator.calculationStringOne = nil;
            self.calculator.calculationStringTwo = nil;
            self.calculator.outputAsString = nil;
        }
    }
}

-(BOOL)unlockCalculatorVault
{
    if([self.calculator.outputAsString isEqualToString:self.userPassword]){
        return YES;
    }
    return NO;
}

@end
