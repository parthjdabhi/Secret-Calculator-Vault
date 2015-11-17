//
//  ContactsTVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/18/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "ContactsTVC.h"
#import "ViewContactVC.h"

@interface ContactsTVC ()

@end

@implementation ContactsTVC

//Create a contactStorage object
-(ContactStorage *)contactStorage
{
    if(!_contactStorage) _contactStorage = [[ContactStorage alloc] init];
    return _contactStorage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //Fetch all of the user's saved contacts
    [self.contactStorage fetchContacts];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Return the number of rows in the section.
    return self.contactStorage.userContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Configure the cell...
    Contacts *contact = [self.contactStorage.userContacts objectAtIndex:indexPath.row];
    NSString *name = [[contact.firstName stringByAppendingString:@" "] stringByAppendingString:contact.lastName];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25.0f];
    [cell.textLabel setText:name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.contactStorage.selectedContact = [self.contactStorage.userContacts objectAtIndex:indexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contactStorage deleteContact:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

//Pass ContactStorage through viewControllers to view-edit user's contact
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toViewContact"]) {
        ViewContactVC *destViewController = segue.destinationViewController;
        destViewController.contactStorage = self.contactStorage;
    }
}

@end
