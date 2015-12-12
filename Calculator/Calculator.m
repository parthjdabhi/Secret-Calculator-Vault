//
//  Calculator.m
//  Calculator
//
//  Created by Corey Allen Pett on 7/7/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize calculationStringOne = _calculationStringOne;
@synthesize calculationStringTwo = _calculationStringTwo;
@synthesize outputAsString = _outputAsString;

//Set up all three strings to "0"
-(NSString *) calculationStringOne
{
    if(!_calculationStringOne) _calculationStringOne = @"0";
    return _calculationStringOne;
}
-(NSString *) calculationStringTwo
{
    if(!_calculationStringTwo) _calculationStringTwo = @"0";
    return  _calculationStringTwo;
}
-(NSString *) outputAsString
{
    if(!_outputAsString) _outputAsString = @"0";
    return _outputAsString;
}

//User is unable to press more than nine digits at a time
-(void)setCalculationStringOne:(NSString *)calculationStringOne
{
    if(calculationStringOne.length <= 9){
        _calculationStringOne = calculationStringOne;
    }
}
-(void)setCalculationStringTwo:(NSString *)calculationStringTwo
{
    if(calculationStringTwo.length <= 9){
        _calculationStringTwo = calculationStringTwo;
    }
}

//Method to make calculations when the "=" button is pressed
//OR when an operator is selected after calculatorStringOne and calculatorStringTwo are filled with digits
-(void)performCalculation
{
    double numberOne;
    double numberTwo;
    double outcome;
    
    numberOne = [self.calculationStringOne doubleValue];
    numberTwo = [self.calculationStringTwo doubleValue];
    
    if ([self.selectedOperator isEqualToString:@"*"]){
        outcome = numberOne * numberTwo;
    }
    else if([self.selectedOperator isEqualToString:@"/"]){
        outcome = numberOne / numberTwo;
    }
    else if([self.selectedOperator isEqualToString:@"+"]){
        outcome = numberOne + numberTwo;
    }
    else if ([self.selectedOperator isEqualToString:@"-"]){
        outcome = numberOne - numberTwo;
    }
    else {
        outcome = numberOne;
    }
    
    self.outputAsString = [NSString stringWithFormat:@"%g", outcome];
    self.calculationStringOne = self.outputAsString;
    self.calculationStringTwo = @"0";
}

//Executed when an operator is selected after calculatorStringOne and calculatorStringTwo are filled with digits
-(void)selectOperator:(NSString *)operator
{
    if (![self.calculationStringOne isEqualToString:@"0"] && ![self.calculationStringTwo isEqualToString:@"0"] && self.selectedOperator){
        [self performCalculation];
    }
    self.selectedOperator = operator;
}

//Executed when "+/-" is pressed
//Add or remove negative sign
-(void)switchSignNumber:(BOOL)isOperatorSelected
{
    //No operator selected
    if (!isOperatorSelected) {
        //Add "-" to StringOne
        if ([self.calculationStringOne rangeOfString:@"-"].location == NSNotFound) {
            self.calculationStringOne = [@"-" stringByAppendingString:self.calculationStringOne];
            self.outputAsString = self.calculationStringOne;
        }
        //Remove "-" from StringOne
        else {
            self.calculationStringOne = [self.calculationStringOne substringFromIndex:1];
            self.outputAsString = self.calculationStringOne;
        }
    }
    //Yes operator selected
    else if(isOperatorSelected){
        //Add "-" to StringTwo
        if ([self.calculationStringTwo rangeOfString:@"-"].location == NSNotFound){
            self.calculationStringTwo = [@"-" stringByAppendingString:self.calculationStringTwo];
            self.outputAsString = self.calculationStringTwo;
        }
        //Remove "-" from StringTwo
        else {
            self.calculationStringTwo = [self.calculationStringTwo substringFromIndex:1];
            self.outputAsString = self.calculationStringTwo;
        }
    }
}


//Executed when "AC-C" is pressed
//Clear the calculator
-(void)clearCalculator
{
    self.calculationStringOne = @"0";
    self.calculationStringTwo = @"0";
    self.outputAsString = @"0";
}

//Used to move the decmial over to the left twice when "%" is pressed
-(NSString *)convertStringToPercentage:(NSString *)string
{
    double value = [string doubleValue];
    value = value / 100;
    string = [NSString stringWithFormat:@"%g", value];
    return string;
}

//Executed when "." is pressed or "%"
//Add decimal or not to number
-(void)concatDecimal:(BOOL)isPercentage
  isOperatorSelected:(BOOL)isOperatorSelected
{
    //If "." is not found
    if ([self.outputAsString rangeOfString:@"."].location == NSNotFound && !isPercentage){
        if(!isOperatorSelected){
            self.calculationStringOne = [self.calculationStringOne stringByAppendingString:@"."];
            self.outputAsString = self.calculationStringOne;
        }
        else if (isOperatorSelected){
            self.calculationStringTwo = [self.calculationStringTwo stringByAppendingString:@"."];
            self.outputAsString = self.calculationStringTwo;
        }
    }
    //If "." is found
    else {
        if(!isOperatorSelected){
            if (isPercentage){
                self.calculationStringOne = [self convertStringToPercentage:self.calculationStringOne];
                self.outputAsString = self.calculationStringOne;
            }
        }
        else if (isOperatorSelected) {
            if (isPercentage) {
                self.calculationStringTwo = [self convertStringToPercentage:self.calculationStringTwo];
                self.outputAsString = self.calculationStringTwo;
            }
        }
    }
}

//Create the output to display and calculate
-(void)concatNumber:(NSString *)numberPressed
 isOperatorSelected:(BOOL)isOperatorSelected
{
    //Operater not selected
    if(!isOperatorSelected){
        //String is empty
        if ([self.calculationStringOne isEqualToString:@"0"]){
            self.calculationStringOne = numberPressed;
            self.outputAsString = self.calculationStringOne;
        }
        //String is not empty
        else {
            self.calculationStringOne = [self.calculationStringOne stringByAppendingString:numberPressed];
            self.outputAsString = self.calculationStringOne;
        }
    }
    //Operator selected
    else if (isOperatorSelected){
        //String is empty
        if ([self.calculationStringTwo isEqualToString:@"0"]){
            self.calculationStringTwo = numberPressed;
            self.outputAsString = self.calculationStringTwo;
        }
        //String is not empty
        else {
            self.calculationStringTwo = [self.calculationStringTwo stringByAppendingString:numberPressed];
            self.outputAsString = self.calculationStringTwo;
        }
    }
}

//Convert to number, format it, convert to string and return
-(NSString *)formatStringToDisplay:(BOOL)isOperatorSelected
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.maximumIntegerDigits = 9;
    numberFormatter.maximumFractionDigits = 9;
    numberFormatter.locale = [NSLocale currentLocale];
    if (self.outputAsString.length <= 9){
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    else if (self.outputAsString.length > 9){
        numberFormatter.numberStyle = NSNumberFormatterScientificStyle;
    }
    NSNumber *outputNumber = [NSNumber numberWithDouble:[self.outputAsString doubleValue]];
    NSString *output =  [numberFormatter stringFromNumber:outputNumber];
    
    //Decimal deletes after using NSformatter if decimal is on the end of NSNumber ex. "43." = "43" -- but we need that to display
    //Put that decimal back
    if ([self.outputAsString hasSuffix:@"."]){
        output = [output stringByAppendingString:@"."];
    }
    return output;
}

@end
