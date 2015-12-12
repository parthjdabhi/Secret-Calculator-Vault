//
//  AddPasswordVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/23/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "AddPasswordVC.h"
#import "ViewPasswordVC.h"

@interface AddPasswordVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *websiteTextfield;
@property (weak, nonatomic) IBOutlet UITextField *notesTextfield;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation AddPasswordVC

//If no password exists already, set up passwordStorage object
-(PasswordStorage *)passwordStorage
{
    if(!_passwordStorage) _passwordStorage = [[PasswordStorage alloc] init];
    return _passwordStorage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Manipulate textfield to be rounded
    self.titleTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.websiteTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.notesTextfield.borderStyle = UITextBorderStyleRoundedRect;
    
    //Dismiss keyboard when user presses outside of textfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.titleTextfield.delegate = self;
    self.usernameTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
    self.websiteTextfield.delegate = self;
    self.notesTextfield.delegate = self;
    
    //If editing contact, place current contact information into the contact form
    if (self.passwordStorage.selectedPassword) {
        self.titleTextfield.text = self.passwordStorage.selectedPassword.title;
        self.usernameTextfield.text = self.passwordStorage.selectedPassword.username;
        self.passwordTextfield.text = self.passwordStorage.selectedPassword.password;
        self.notesTextfield.text = self.passwordStorage.selectedPassword.notes;
        self.websiteTextfield.text = self.passwordStorage.selectedPassword.website;
    }
    
    //Enable save button if the first name textfield is filled out
    if (self.titleTextfield.text.length > 0){
        self.saveButton.enabled = YES;
    }
    else{
        self.saveButton.enabled = NO;
    }
    
    //When editing textfields, enable clear button mode
    self.titleTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleTextfield.clearsOnBeginEditing = YES;
    
    self.usernameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameTextfield.clearsOnBeginEditing = YES;
    
    self.passwordTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextfield.clearsOnBeginEditing = YES;
    
    self.websiteTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.websiteTextfield.clearsOnBeginEditing = YES;
    
    self.notesTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.notesTextfield.clearsOnBeginEditing = YES;
    
}

//Dismiss keyboard method for all textfields
-(void)dismissKeyboard
{
    [self.titleTextfield resignFirstResponder];
    [self.usernameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.websiteTextfield resignFirstResponder];
    [self.notesTextfield resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender
{
    //Save user contact information if user is editing a current contact
    if(self.passwordStorage.selectedPassword){
        [self.passwordStorage savePassword:self.titleTextfield.text
                                  username:self.usernameTextfield.text
                                  password:self.passwordTextfield.text
                                   website:self.websiteTextfield.text
                                     notes:self.notesTextfield.text];
    }
    
    //If user is not editing a current contact, create new contact
    else {
        [self.passwordStorage createPassword:self.titleTextfield.text
                                    username:self.usernameTextfield.text
                                    password:self.passwordTextfield.text
                                     website:self.websiteTextfield.text
                                       notes:self.notesTextfield.text];
    }
    //Pass the data back to view the contact
    ViewPasswordVC *destinationController = [[ViewPasswordVC alloc] init];
    destinationController.passwordStorage = self.passwordStorage;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Enable save button when user fills out the firstName.textfield.text
- (IBAction)editingChanged:(UITextField *)textField
{
    //if text field is empty, disable the button
    self.saveButton.enabled = textField.text.length > 0;
    
}

//Called when textField start editing a textfield
//Moves the textfield the user is editing up to the top of the scrollview for visiblity
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0,textField.center.y-100) animated:YES];
}

//Called when user clicks on the return button.
//Move user to the next textfield input
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [self.scrollView setContentOffset:CGPointMake(0,textField.center.y-60) animated:YES];
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

@end
