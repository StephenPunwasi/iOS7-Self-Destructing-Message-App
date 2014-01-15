//
//  LoginViewController.h
//  Ribbit
//
//  Created by Stephen Punwasi on 12/31/13.
//  Copyright (c) 2013 StephenPunwasi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)login:(id)sender;

@end
