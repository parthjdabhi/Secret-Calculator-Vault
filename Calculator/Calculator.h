//
//  Calculator.h
//  Calculator
//
//  Created by Corey Allen Pett on 7/7/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

//Used to display calculated numbers
@property (nonatomic, strong) NSString *outputAsString;
@property (nonatomic, strong) NSString *calculationStringTwo;
@property (nonatomic, strong) NSString *calculationStringOne;
@property (nonatomic, strong) NSString *selectedOperator;

//Used for creating user password
@property (nonatomic, strong) NSString *userPassword;
@property (nonatomic) BOOL isPasswordCreated;
-(BOOL)unlockCalculatorVault;
-(void)retrievePassword;
-(void)createUserPassword;

//Operations Use
-(void)switchSignNumber:(BOOL)isOperatorSelected;
-(void)performCalculation;
-(void)selectOperator:(NSString *)operator;
-(void)clearCalculator;

//Numbers Use
-(void)concatNumber:(NSString *)numberPressed
 isOperatorSelected:(BOOL)isOperatorSelected;
-(void)concatDecimal:(BOOL)isPercentage
  isOperatorSelected:(BOOL)isOperatorSelected;
-(NSString *)formatStringToDisplay:(BOOL)isOperatorSelected;

@end
