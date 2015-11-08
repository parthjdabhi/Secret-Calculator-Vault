//
//  CBLayer.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/24/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "CBLayer.h"

@implementation CBLayer

- (id)initWithCoder:(NSCoder *)coder
{
    // Call the parent implementation of initWithCoder
    self = [super initWithCoder:coder];
    
    // Custom drawing methods
    if (self)
    {
        [self drawButton];
        [self drawInnerGlow];
        [self drawBackgroundLayer];
        [self drawHighlightBackgroundLayer];
    }
    
    return self;
}

- (void)drawButton
{
    // Get the root layer (any UIView subclass comes with one)
    CALayer *layer = self.layer;
    
    layer.cornerRadius = 4.5f;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor colorWithRed:0.77f green:0.43f blue:0.00f alpha:1.00f].CGColor;
}

-(void)drawHighlightBackgroundLayer
{
    // Check if the property has been set already
    if (!_highlightBackgroundLayer)
    {
        // Instantiate the gradient layer
        _highlightBackgroundLayer = [CAGradientLayer layer];
        
        // Set the colors
        _highlightBackgroundLayer.colors = (@[
                                     (id)[UIColor colorWithRed:1.94f green:0.82f blue:0.52f alpha:0.0f].CGColor,
                                     (id)[UIColor colorWithRed:1.91f green:0.55f blue:0.00f alpha:0.0f].CGColor
                                     ]);
        
        // Set the stops
        _highlightBackgroundLayer.locations = (@[
                                        @0.0f,
                                        @1.0f
                                        ]);
        
        // Add the gradient to the layer hierarchy
        [self.layer insertSublayer:_highlightBackgroundLayer atIndex:0];
    }
}

- (void)drawBackgroundLayer
{
    // Check if the property has been set already
    if (!_backgroundLayer)
    {
        // Instantiate the gradient layer
        _backgroundLayer = [CAGradientLayer layer];
        
        // Set the colors
        _backgroundLayer.colors = (@[
                                     (id)[UIColor colorWithRed:0.94f green:0.82f blue:0.52f alpha:1.00f].CGColor,
                                     (id)[UIColor colorWithRed:0.91f green:0.55f blue:0.00f alpha:1.00f].CGColor
                                     ]);
        
        // Set the stops
        _backgroundLayer.locations = (@[
                                        @0.0f,
                                        @1.0f
                                        ]);
        
        // Add the gradient to the layer hierarchy
        [self.layer insertSublayer:_backgroundLayer atIndex:0];
    }
}

- (void)drawInnerGlow
{
    if (!_innerGlow)
    {
        // Instantiate the innerGlow layer
        _innerGlow = [CALayer layer];
        
        _innerGlow.cornerRadius= 4.5f;
        _innerGlow.borderWidth = 1;
        _innerGlow.borderColor = [[UIColor whiteColor] CGColor];
        _innerGlow.opacity = 0.5;
        
        [self.layer insertSublayer:_innerGlow atIndex:2];
    }
}

- (void)layoutSubviews
{
    // Set inner glow frame (1pt inset)
    _innerGlow.frame = CGRectInset(self.bounds, 1, 1);
    
    // Set gradient frame (fill the whole button))
    _backgroundLayer.frame = self.bounds;
    
    // Set inverted gradient frame
    _highlightBackgroundLayer.frame = self.bounds;
    
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted
{
    // Disable implicit animations
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    // Hide/show inverted gradient
    _highlightBackgroundLayer.hidden = !highlighted;
    
    [CATransaction commit];
    
    [super setHighlighted:highlighted];
}

+ (CBLayer *)buttonWithType:(UIButtonType)type
{
    return [super buttonWithType:UIButtonTypeCustom];
}

@end
