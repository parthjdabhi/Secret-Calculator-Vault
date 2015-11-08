//
//  ViewNoteVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 10/5/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "ViewNoteVC.h"

@interface ViewNoteVC () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewNoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    
    //Dismiss the keyboard when the user taps
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    //If a editing note, place current note informtion into the note
    if (self.note){
        self.textView.text = [self.note valueForKey:@"notes"];
        self.dateLabel.text = [@"Last edited On: " stringByAppendingString:[NSDateFormatter localizedStringFromDate:[self.note valueForKey: @"date"]
                                                                                                    dateStyle:NSDateFormatterShortStyle
                                                                                                    timeStyle:NSDateFormatterShortStyle]];
    }
    //Enable save button if the user has text in his/her note
    if(self.textView.text.length > 0){
        self.saveButton.enabled = YES;
    }
    else{
        self.saveButton.enabled = NO;
    }
}

//Dismiss keyboard method
-(void)dismissKeyboard
{
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)saveButton:(id)sender
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //Save user note information when user is editing a current note
    if (self.note){
        [self.note setValue:self.textView.text forKey:@"notes"];
        
        //Set the title no bigger than 30 characters
        if(self.textView.text.length > 30){
            [self.note setValue:[self.textView.text substringToIndex:30] forKey:@"title"];
        }
        else{
            [self.note setValue:self.textView.text forKey:@"title"];        }
        [self.note setValue:[NSDate date] forKey:@"date"];
    }
    
    //If user is not editing a current note, create new note
    else {
        Notes *newNote = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:context];
        newNote.date = [NSDate date];
        
        //Set the title no bigger than 30 characters
        if(self.textView.text.length > 30){
            newNote.title = [self.textView.text substringToIndex:30];
        }
        else{
            newNote.title = self.textView.text;
        }
        newNote.notes = self.textView.text;
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //Set the date the note was last edited on
    self.dateLabel.text = [@"Last edited On: " stringByAppendingString:[NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle]];
    
    //Enable save button if the user has text in his/her note
    if(self.textView.text.length > 0){
        self.saveButton.enabled = YES;
    }
    else{
        self.saveButton.enabled = NO;
    }
}

//Set up NSManagedObject for fetching-saving
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
