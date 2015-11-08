//
//  NavigationViewController.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/1/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "NavigationViewController.h"
//#import "SWRevealViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController
{
    NSArray *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = @[@"first", @"second", @"third", @"fourth", @"fifth", @"sixth", @"seventh"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [menu count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}




#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
//        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
//        
//        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
//        
//            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
//            [navController setViewControllers: @[dvc] animated: NO ];
//            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
//        };
//    }
//}
// 

@end
