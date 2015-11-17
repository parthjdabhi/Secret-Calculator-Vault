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

-(NoteStorage *)noteStorage
{
    if(!_noteStorage) _noteStorage = [[NoteStorage alloc] init];
    return _noteStorage;
}

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
    [self.noteStorage fetchNotes];
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
        return self.noteStorage.userNotes.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Notes *note = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        note = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        note = [self.noteStorage.userNotes objectAtIndex:indexPath.row];
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [self.noteStorage deleteNote:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//Filter the results when user types into the searchBar
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSArray *userNotesArray = [self.noteStorage.userNotes copy];
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

#pragma mark - Navigation

//Pass noteStorage to ViewNote
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
    if ([[segue identifier] isEqualToString:@"toViewNote"]) {
        NSIndexPath *indexPath = nil;
        NSManagedObject *selectedNote;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            self.noteStorage.selectedNote = [self.searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            self.noteStorage.selectedNote = [self.noteStorage.userNotes objectAtIndex:indexPath.row];
        }
    ViewNoteVC *destViewController = segue.destinationViewController;
        destViewController.noteStorage = self.noteStorage;
    }
 }

@end
