//
//  ImageViewController.h
//  Ribbit
//
//  Created by Stephen Punwasi on 1/1/14.
//  Copyright (c) 2014 StephenPunwasi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property (nonatomic, strong) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
