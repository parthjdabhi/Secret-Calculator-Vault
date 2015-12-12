//
//  Settings.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/19/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property (strong, nonatomic) NSString *currentLock;
@property (strong, nonatomic) NSString *userPassword;
@property (nonatomic) BOOL isPasswordCreated;


-(BOOL)unlockVault:(NSString *)input;
-(void)createUserPassword:(NSString *)input;
-(void)resetUserPassword;
-(void)retrievePassword;
-(void)retrieveCurrentLock;
-(void)setLock:(NSString *)lockType;

@end
