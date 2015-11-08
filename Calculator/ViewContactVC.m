//
//  EditContactVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/18/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "ViewContactVC.h"
#import "AddContactVC.h"
#import <MessageUI/MessageUI.h>

@interface ViewContactVC () <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *companyButton;
@property (weak, nonatomic) IBOutlet UIButton *mobileButton;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *workButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *webpageButton;
@property (weak, nonatomic) IBOutlet UIButton *notesButton;

@end

@implementation ViewContactVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //Inserts and formats users contact information for display
    self.nameLabel.text = [[[self.contact valueForKey:@"firstName"] stringByAppendingString:@" "] stringByAppendingString:[self.contact valueForKey:@"lastName"]];
    
    [self.companyButton setAttributedTitle:[self changeLabelTitle:@"Company: " labelName:[self.contact valueForKey:@"company"] startRange:9] forState:UIControlStateNormal];
    
    [self.mobileButton setAttributedTitle:[self changeLabelTitle:@"Mobile: " labelName:[self.contact valueForKey:@"mobileNumber"] startRange:8] forState:UIControlStateNormal];
    
    [self.homeButton setAttributedTitle:[self changeLabelTitle:@"Home: " labelName:[self.contact valueForKey:@"homeNumber"] startRange:5] forState:UIControlStateNormal];
    
    [self.workButton setAttributedTitle:[self changeLabelTitle:@"Work: " labelName:[self.contact valueForKey:@"workNumber"] startRange:6] forState:UIControlStateNormal];
    
    [self.emailButton setAttributedTitle:[self changeLabelTitle:@"Email: " labelName:[self.contact valueForKey:@"email"] startRange:7] forState:UIControlStateNormal];
    
    [self.webpageButton setAttributedTitle:[self changeLabelTitle:@"Website: " labelName:[self.contact valueForKey:@"website"] startRange:9] forState:UIControlStateNormal];
    
    [self.notesButton setAttributedTitle:[self changeLabelTitle:@"Notes: " labelName:[self.contact valueForKey:@"notes"]startRange:7] forState:UIControlStateNormal];
}

//Formats user information
-(NSAttributedString *)changeLabelTitle:(NSString *)label labelName:(NSString *)labelName startRange:(int)start
{
    if (!labelName){
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:labelName];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,labelName.length)];
        return attString;
    }
    else {
        NSString *string = [label stringByAppendingString:labelName];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(start, string.length - start)];
        return attString;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Call mobile phone when pressed
- (IBAction)mobileButton:(id)sender
{
    if([self.contact valueForKey:@"mobileNumber"]){
        NSString *mobileNumber = [self.contact valueForKey:@"mobileNumber"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:mobileNumber]]];
    }
}

//Call home phone when pressed
- (IBAction)homeButton:(id)sender
{
    if([self.contact valueForKey:@"homeNumber"]){
        NSString *homeNumber = [self.contact valueForKey:@"homeNumber"];
        [[UIApplication sharedApplication]
         openURL:[NSURL URLWithString:[@"tel://" stringByAppendingPathComponent:homeNumber]]];
    }
}

//Call work phone when pressed
- (IBAction)workButton:(id)sender
{
    if([self.contact valueForKey:@"workNumber"]){
        NSString *workNumber = [self.contact valueForKey:@"workNumber"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingPathComponent:workNumber]]];
    }
}

//Composes an email for user when pressed
- (IBAction)emailButton:(id)sender
{
    if([self.contact valueForKey:@"email"]){
        NSString *email = [self.contact valueForKey:@"email"];
        NSArray *toRecipents = [NSArray arrayWithObject:email];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

//Opens URL when pressed
- (IBAction)webpageButton:(id)sender
{
    if([self.contact valueForKey:@"website"]){
    NSString *webpage = [@"https://" stringByAppendingString:[self.contact valueForKey:@"website"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webpage]];
    }
}

//Used to create an email for the user
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toAddContact"]) {
        NSManagedObject *selectedContact = self.contact;
        AddContactVC *destViewController = segue.destinationViewController;
        destViewController.updateContact = selectedContact;
    }
}

@end
