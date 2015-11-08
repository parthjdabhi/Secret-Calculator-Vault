//
//  NotesTVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/23/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "NotesTVC.h"
#import "ViewNoteVC.h"

@interface NotesTVC () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation NotesTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView setContentOffset:CGPointMake(0,44) animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Fetch all the users saved notes
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Notes"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    self.userNotes = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Hide the keyboard when cancel button is pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
        
    } else {
        return self.userNotes.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Notes *note = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        note = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        note = [self.userNotes objectAtIndex:indexPath.row];
    }
    
    //Configure the cell...
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25.0f];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [note valueForKey:@"title"]]];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[note valueForKey:@"date"]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    [cell.detailTextLabel setText:dateString];
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
        [context deleteObject:[self.userNotes objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove note from the table view
        [self.userNotes removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//Filter the results when user types into the searchBar
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSArray *userNotesArray = [self.userNotes copy];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    self.searchResults = [userNotesArray filteredArrayUsingPredicate:resultPredicate];
}

//Filter the results when user types into the searchBar
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

//Set up NSManagedObject for fetching
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark - Navigation

//Pass NSManagedObject through viewControllers to view-edit user's password
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
    if ([[segue identifier] isEqualToString:@"toViewNote"]) {
        NSIndexPath *indexPath = nil;
        NSManagedObject *selectedNote;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            selectedNote = [self.searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            selectedNote = [self.userNotes objectAtIndex:indexPath.row];
        }
    ViewNoteVC *destViewController = segue.destinationViewController;
    destViewController.note = selectedNote;
    }
 }

@end
