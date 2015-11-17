//
//  PasswordTVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/23/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "PasswordTVC.h"
#import "ViewPasswordVC.h"

@interface PasswordTVC ()

@end

@implementation PasswordTVC

//Create passwordStorage object
-(PasswordStorage *)passwordStorage
{
    if(!_passwordStorage) _passwordStorage = [[PasswordStorage alloc] init];
    return _passwordStorage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //Fetch all the users saved passwords
    [self.passwordStorage fetchPasswords];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.passwordStorage.userPasswords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // Configure the cell...
    Passwords *password = [self.passwordStorage.userPasswords objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25.0f];
    [cell.textLabel setText:password.title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.passwordStorage.selectedPassword = [self.passwordStorage.userPasswords objectAtIndex:indexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [self.passwordStorage deletePassword:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Navigation

//Pass NSManagedObject through viewControllers to view-edit user's password
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toViewPassword"]) {
        ViewPasswordVC *destViewController = segue.destinationViewController;
        destViewController.passwordStorage = self.passwordStorage;
    }
}

@end
