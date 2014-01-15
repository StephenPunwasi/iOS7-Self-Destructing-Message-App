//
//  SignUpViewController.h
//  Ribbit
//
//  Created by Stephen Punwasi on 12/31/13.
//  Copyright (c) 2013 StephenPunwasi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)signup:(id)sender;

@end
