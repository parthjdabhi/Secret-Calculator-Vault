//
//  AddContactVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/19/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "AddContactVC.h"
#import "ViewContactVC.h"

@interface AddContactVC () <UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *companyTextfield;

@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *homeNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *workNumberTextfield;

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *webpageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *notesTextfield;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AddContactVC

//If no contact exists already, set up contactStorage object
-(ContactStorage *)contactStorage
{
    if(!_contactStorage) _contactStorage = [[ContactStorage alloc] init];
    return _contactStorage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Used to fix scrollview from not scrolling
    self.scrollView.delegate = self;
    UIView *contentView;
    [self.scrollView addSubview:contentView];
    [self.scrollView setContentSize:contentView.frame.size];
    
    //Manipulate textfield to be rounded
    self.firstNameTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.lastNameTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.companyTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.mobileNumberTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.homeNumberTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.workNumberTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.emailTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.webpageTextfield.borderStyle = UITextBorderStyleRoundedRect;
    self.notesTextfield.borderStyle = UITextBorderStyleRoundedRect;
    
    //Dismiss keyboard when user presses outside of textfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.firstNameTextfield.delegate = self;
    self.lastNameTextfield.delegate = self;
    self.companyTextfield.delegate = self;
    self.mobileNumberTextfield.delegate = self;
    self.homeNumberTextfield.delegate = self;
    self.workNumberTextfield.delegate = self;
    self.emailTextfield.delegate = self;
    self.notesTextfield.delegate = self;
    self.webpageTextfield.delegate = self;
    
    //If editing contact, place current contact information into the contact form
    if(self.contactStorage.selectedContact) {
        self.firstNameTextfield.text = self.contactStorage.selectedContact.firstName;
        self.lastNameTextfield.text = self.contactStorage.selectedContact.lastName;
        self.companyTextfield.text = self.contactStorage.selectedContact.company;
        self.mobileNumberTextfield.text = self.contactStorage.selectedContact.mobileNumber;
        self.homeNumberTextfield.text = self.contactStorage.selectedContact.homeNumber;
        self.workNumberTextfield.text = self.contactStorage.selectedContact.workNumber;
        self.emailTextfield.text = self.contactStorage.selectedContact.email;
        self.notesTextfield.text = self.contactStorage.selectedContact.notes;
        self.webpageTextfield.text = self.contactStorage.selectedContact.website;
    }
    
    //Enable save button if the first name textfield is filled out
    if (self.firstNameTextfield.text.length > 0){
        self.saveButton.enabled = YES;
    }
    else{
        self.saveButton.enabled = NO;
    }
    
    //When editing textfields, enable clear button mode
    self.firstNameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.firstNameTextfield.clearButtonMode = YES;
    
    self.lastNameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.lastNameTextfield.clearButtonMode = YES;
    
    self.companyTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.companyTextfield.clearButtonMode = YES;
    
    self.mobileNumberTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.mobileNumberTextfield.clearButtonMode = YES;
    
    self.homeNumberTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.homeNumberTextfield.clearButtonMode = YES;
    
    self.workNumberTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.workNumberTextfield.clearButtonMode = YES;
    
    self.emailTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.emailTextfield.clearButtonMode = YES;
    
    self.notesTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.notesTextfield.clearButtonMode = YES;
    
    self.webpageTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.webpageTextfield.clearButtonMode = YES;
    
}

//Dismiss keyboard method for all textfields
-(void)dismissKeyboard {
    [self.firstNameTextfield resignFirstResponder];
    [self.lastNameTextfield resignFirstResponder];
    [self.companyTextfield resignFirstResponder];
    [self.mobileNumberTextfield resignFirstResponder];
    [self.homeNumberTextfield resignFirstResponder];
    [self.workNumberTextfield resignFirstResponder];
    [self.emailTextfield resignFirstResponder];
    [self.notesTextfield resignFirstResponder];
    [self.webpageTextfield resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender
{
    //Save user contact information when user is editing a current contact
    if(self.contactStorage.selectedContact){
        [self.contactStorage saveContact:self.firstNameTextfield.text
                                  lastName:self.lastNameTextfield.text
                                   company:self.companyTextfield.text
                              mobileNumber:self.mobileNumberTextfield.text
                                homeNumber:self.homeNumberTextfield.text
                                workNumber:self.workNumberTextfield.text
                                     email:self.emailTextfield.text
                                     notes:self.notesTextfield.text
                                   website:self.webpageTextfield.text];
    }
    
    //If user is not editing a current contact, create new contact
    else {
        [self.contactStorage createContact:self.firstNameTextfield.text
                                  lastName:self.lastNameTextfield.text
                                   company:self.companyTextfield.text
                              mobileNumber:self.mobileNumberTextfield.text
                                homeNumber:self.homeNumberTextfield.text
                                workNumber:self.workNumberTextfield.text
                                     email:self.emailTextfield.text
                                     notes:self.notesTextfield.text
                                   website:self.webpageTextfield.text];
    }
    //Pass the data back to view the contact
    ViewContactVC *destinationController = [[ViewContactVC alloc] init];
    destinationController.contactStorage = self.contactStorage;
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
