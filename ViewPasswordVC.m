//
//  EditPasswordVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 9/23/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import "ViewPasswordVC.h"
#import "AddPasswordVC.h"

@interface ViewPasswordVC () 
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *usernameButton;
@property (weak, nonatomic) IBOutlet UIButton *passwordButton;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIButton *notesButton;


@end

@implementation ViewPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    //Inserts and formats users contact information for display
    self.titleLabel.text = self.passwordStorage.selectedPassword.title;
    [self.usernameButton setAttributedTitle:[self changeLabelTitle:@"Username: " labelName:self.passwordStorage.selectedPassword.username startRange:10] forState:UIControlStateNormal];
    
    [self.passwordButton setAttributedTitle:[self changeLabelTitle:@"Password: " labelName:self.passwordStorage.selectedPassword.password startRange:10] forState:UIControlStateNormal];
    
    [self.websiteButton setAttributedTitle:[self changeLabelTitle:@"Website: " labelName:self.passwordStorage.selectedPassword.website startRange:9] forState:UIControlStateNormal];
    
    [self.notesButton setAttributedTitle:[self changeLabelTitle:@"Notes: " labelName:self.passwordStorage.selectedPassword.notes startRange:7] forState:UIControlStateNormal];
}

//Formats user information
-(NSAttributedString *)changeLabelTitle:(NSString *)label labelName:(NSString *)labelName startRange:(int)start
{
    if (!labelName) {
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

//Opens URL when pressed
- (IBAction)websiteButton:(id)sender
{
    if(self.passwordStorage.selectedPassword.website){
        NSString *webAddress = [@"http://" stringByAppendingString:self.passwordStorage.selectedPassword.website];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webAddress]];
    }
}

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toAddPassword"]) {
        AddPasswordVC *destViewController = segue.destinationViewController;
        destViewController.passwordStorage = self.passwordStorage;
    }
}

@end
