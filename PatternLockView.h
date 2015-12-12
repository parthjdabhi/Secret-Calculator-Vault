//
//  PatternLockView.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/27/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatternLockView : UIView {
    NSValue *_trackPointValue;
    NSMutableArray *_dotViews;
}

-(void)clearDotViews;
-(void)addDotView:(UIView *)view;
-(void)drawLineFromLastDotTo:(CGPoint)pt;

@end
