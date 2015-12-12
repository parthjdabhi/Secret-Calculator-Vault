//
//  PatternVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/26/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "PatternVC.h"
#import "PatternLockView.h"

#define MATRIX_SIZE 3

@interface PatternVC ()

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIButton *dotView_1;
@property (weak, nonatomic) IBOutlet UIButton *dotView_2;
@property (weak, nonatomic) IBOutlet UIButton *dotView_3;
@property (weak, nonatomic) IBOutlet UIButton *dotView_4;
@property (weak, nonatomic) IBOutlet UIButton *dotView_5;
@property (weak, nonatomic) IBOutlet UIButton *dotView_6;
@property (weak, nonatomic) IBOutlet UIButton *dotView_7;
@property (weak, nonatomic) IBOutlet UIButton *dotView_8;
@property (weak, nonatomic) IBOutlet UIButton *dotView_9;
@property (strong, nonatomic) NSMutableArray *buttonCollection;

@end

@implementation PatternVC

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    //self.view = [[PatternLockView alloc] init];
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.view.backgroundColor = [UIColor darkGrayColor];
//    
//    for (int i=0; i<MATRIX_SIZE; i++) {
//        for (int j=0; j<MATRIX_SIZE; j++) {
//            UIImage *dotImage = [UIImage imageNamed:@"blackdot"];
//            UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImage
//                                                       highlightedImage:[UIImage imageNamed:@"bullseye"]];
//            imageView.frame = CGRectMake(0, 0, dotImage.size.width, dotImage.size.height);
//            imageView.userInteractionEnabled = YES;
//            imageView.tag = j*MATRIX_SIZE + i + 1;
//            [self.view addSubview:imageView];
//        }
//    }
//}
//
- (void)viewWillLayoutSubviews {
    int w = self.view.frame.size.width/MATRIX_SIZE;
    int h = self.view.frame.size.height/MATRIX_SIZE;
    
    int i=0;
    for (UIView *view in self.view.subviews)
        if ([view isKindOfClass:[UIImageView class]]) {
            int x = w*(i/MATRIX_SIZE) + w/2;
            int y = h*(i%MATRIX_SIZE) + h/2;
            view.center = CGPointMake(x, y);
            i++;
        }
    
}

-(void)viewDidLoad
{
    [self.view addSubview:self.dotView_1];
    [self.view addSubview:self.dotView_2];
    [self.view addSubview:self.dotView_3];
    [self.view addSubview:self.dotView_4];
    [self.view addSubview:self.dotView_5];
    [self.view addSubview:self.dotView_6];
    [self.view addSubview:self.dotView_7];
    [self.view addSubview:self.dotView_8];
    [self.view addSubview:self.dotView_9];
    [self.buttonCollection addObject:self.dotView_1];
    [self.buttonCollection addObject:self.dotView_2];
    [self.buttonCollection addObject:self.dotView_3];
    [self.buttonCollection addObject:self.dotView_4];
    [self.buttonCollection addObject:self.dotView_5];
    [self.buttonCollection addObject:self.dotView_6];
    [self.buttonCollection addObject:self.dotView_7];
    [self.buttonCollection addObject:self.dotView_8];
    [self.buttonCollection addObject:self.dotView_9];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
    return NO;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _paths = [[NSMutableArray alloc] init];
}



- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    UIView *touched = [self.view hitTest:pt withEvent:event];
    
    PatternLockView *v = (PatternLockView*)self.view;
    [v drawLineFromLastDotTo:pt];
    
    if (touched!=self.view) {
        NSLog(@"touched view tag: %d ", touched.tag);
        
        BOOL found = NO;
        for (NSNumber *tag in _paths) {
            found = tag.integerValue==touched.tag;
            if (found)
                break;
        }
        
        if (found)
            return;
        
        [_paths addObject:[NSNumber numberWithInt:touched.tag]];
        [v addDotView:touched];
        
        UIImageView* iv = (UIImageView*)touched;
        iv.highlighted = YES;
    }
    
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // clear up hilite
    PatternLockView *v = (PatternLockView*)self.view;
    [v clearDotViews];
    
    for (UIView *view in self.view.subviews)
        if ([view isKindOfClass:[UIImageView class]])
            [(UIImageView*)view setHighlighted:NO];
    
    [self.view setNeedsDisplay];
    
    // pass the output to target action...
    if (_target && _action)
        [_target performSelector:_action withObject:[self getKey]];
}


// get key from the pattern drawn
// replace this method with your own key-generation algorithm
- (NSString*)getKey {
    NSMutableString *key;
    key = [NSMutableString string];
    
    // simple way to generate a key
    for (NSNumber *tag in _paths) {
        [key appendFormat:@"%02d", tag.integerValue];
    }
    
    return key;
}


- (void)setTarget:(id)target withAction:(SEL)action {
    _target = target;
    _action = action;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
