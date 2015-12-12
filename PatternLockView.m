//
//  PatternLockView.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/27/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "PatternLockView.h"

@implementation PatternLockView




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"drawrect...");
    
    if (!_trackPointValue)
        return;
    
    //Setup graphic
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set graphic/line width
    CGContextSetLineWidth(context, 10.0);
    //Setup color for graphic
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    //Set color
    CGFloat components[] = {0.5, 0.5, 0.5, 0.8};
    //Create color reference
    CGColorRef color = CGColorCreate(colorspace, components);
    //Add color to graphic/line
    CGContextSetStrokeColorWithColor(context, color);
    
    CGPoint from;
    UIView *lastDot;
    //Create line from one dot to the next
    for (UIView *dotView in _dotViews) {
        from = dotView.center;
        NSLog(@"drawing dotview: %@", dotView);
        NSLog(@"\tdrawing from: %f, %f", from.x, from.y);
        
        //Create line from last selected dot to where the user has his/her finger
        if (!lastDot)
            CGContextMoveToPoint(context, from.x, from.y);
        //Attach line to the next dot the user selected
        else
            CGContextAddLineToPoint(context, from.x, from.y);
        
        lastDot = dotView;
    }
    
    CGPoint pt = [_trackPointValue CGPointValue];
    NSLog(@"\t to: %f, %f", pt.x, pt.y);
    //Create line from last selected dot to where the user has his/her finger
    CGContextAddLineToPoint(context, pt.x, pt.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
    _trackPointValue = nil;

}

- (void)clearDotViews
{
    [_dotViews removeAllObjects];
}


- (void)addDotView:(UIView *)view
{
    if (!_dotViews)
        _dotViews = [NSMutableArray array];
    
    [_dotViews addObject:view];
}


- (void)drawLineFromLastDotTo:(CGPoint)pt
{
    _trackPointValue = [NSValue valueWithCGPoint:pt];
    [self setNeedsDisplay];
}


@end
