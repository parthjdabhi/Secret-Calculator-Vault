//
//  ViewNoteVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 10/5/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "ViewNoteVC.h"

@interface ViewNoteVC () <UITextViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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
    self.scrollView.delegate = self;

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

//Save user's notes, then navigate back to user's notes tableview
- (IBAction)backButton:(id)sender
{
    //Save user note information when user is editing a current note
    if (self.noteStorage.selectedNote){
        self.noteStorage.selectedNote.notes = self.textView.text;
        
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

//Save user's notes, then dismiss keyboard
- (IBAction)saveButton:(id)sender
{
    //Save user note information if user is editing a current note
    if (self.noteStorage.selectedNote){
        [self.noteStorage saveNote:self.textView.text];
    }
    
    //If user is not editing a current note, create new note
    else {
        [self.noteStorage createNote:self.textView.text];
    }
    
    [self dismissKeyboard];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //Set the date the note was last edited on
    [self animateTextView: YES];
    self.dateLabel.text = [@"Last edited On: " stringByAppendingString:[NSDateFormatter localizedStringFromDate:[NSDate date]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle]];
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.center.y-100) animated:YES];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView:NO];
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

- (void) animateTextView:(BOOL)up
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    NSLog(@"screen width = %f", screenWidth);
    NSLog(@"screen height = %f", screenHeight);

    const int movementDistance = screenHeight/20;
    const float movementDuration = 0.3f; // tweak as needed
    int movement= movement = (up ? -movementDistance : movementDistance);
    NSLog(@"%d",movement);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
