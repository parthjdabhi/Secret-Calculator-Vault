//
//  CBLayer.h
//  Calculator
//
//  Created by Corey Allen Pett on 9/24/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBLayer : UIButton

@property (strong,nonatomic) CAGradientLayer *backgroundLayer, *highlightBackgroundLayer;
@property (strong,nonatomic) CALayer *innerGlow;

@end
