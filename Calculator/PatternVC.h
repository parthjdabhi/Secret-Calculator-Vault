//
//  PatternVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/26/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatternVC : UIViewController {
    NSMutableArray* _paths;
    
    // after pattern is drawn, call this:
    id _target;
    SEL _action;
}

@property (nonatomic) BOOL changeLock;
@property (nonatomic) BOOL lockVault;

// get key from the pattern drawn
- (NSString*)getKey;

- (void)setTarget:(id)target withAction:(SEL)action;

@end
