//
//  PhotoTVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 10/13/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "PhotoTVC.h"
#import "PhotoCVC.h"

@interface PhotoTVC () <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *firstPhotos;

@end

@implementation PhotoTVC

//Create a PhotoStorage Object
-(PhotoStorage *) photoStorage
{
    if (!_photoStorage) _photoStorage = [[PhotoStorage alloc] init];
    return _photoStorage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.photoStorage fetchAlbums];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Display UIAlert to user to add an album
- (IBAction)addAlbumButton:(id)sender
{
    UIAlertController *addAlbumAlert = [UIAlertController alertControllerWithTitle:@"Enter Album Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self.photoStorage createNewAlbum:addAlbumAlert.textFields.firstObject.text];
                                   [self.tableView reloadData];
                               }];
    [addAlbumAlert addAction:cancelAction];
    [addAlbumAlert addAction:okAction];
    
    [addAlbumAlert addTextFieldWithConfigurationHandler:^(UITextField *textfield)
     {
         textfield.placeholder = NSLocalizedString(@"Enter Album", @"Enter Album");
     }];
    [self presentViewController:addAlbumAlert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoStorage.userAlbums.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Configure the cell..
    Album *album = [self.photoStorage.userAlbums objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25.0f];
    [cell.textLabel setText:[album valueForKey:@"title"]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.photoStorage.userAlbums objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove album from table view
        [self.photoStorage.userAlbums removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.photoStorage.selectedAlbum = [self.photoStorage.userAlbums objectAtIndex:indexPath.row];
}

//Set up NSManagedObject for deleting an object
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark - Navigation

//Pass NSManagedObject through viewControllers to add photos
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"toCollectionView"]){
        PhotoCVC *destViewController = segue.destinationViewController;
        destViewController.photoStorage = self.photoStorage;
    }
}

@end
