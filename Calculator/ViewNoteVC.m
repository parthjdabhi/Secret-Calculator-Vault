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

-(NoteStorage *)noteStorage
{
    if(!_noteStorage) _noteStorage = [[NoteStorage alloc] init];
    return _noteStorage;
}

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
    if (self.noteStorage.selectedNote){
        self.textView.text = self.noteStorage.selectedNote.notes;
        self.dateLabel.text = [@"Last edited On: " stringByAppendingString:[NSDateFormatter localizedStringFromDate:self.noteStorage.selectedNote.date
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
    //Save user note information when user is editing a current note
    if (self.noteStorage.selectedNote){
        self.textView.text = self.noteStorage.selectedNote.notes;
        
        //Set the title no bigger than 30 characters
        if(self.textView.text.length > 30){
            self.noteStorage.selectedNote.title = [self.textView.text substringToIndex:30];
        }
        else{
            self.noteStorage.selectedNote.title = self.textView.text;
            self.noteStorage.selectedNote.date = [NSDate date];
        }
    }
    
    //If user is not editing a current note, create new note
    else {
        [self.noteStorage createNote:self.textView.text];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //Set the date the note was last edited on
    self.dateLabel.text = [@"Last edited On: " stringByAppendingString:[NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle]];
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    //Enable save button if the user has text in his/her note
    if(self.textView.text.length > 0){
        self.saveButton.enabled = YES;
    }
    else{
        self.saveButton.enabled = NO;
    }
}

@end
