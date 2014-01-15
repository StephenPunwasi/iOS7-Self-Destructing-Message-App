//
//  ImageViewController.m
//  Ribbit
//
//  Created by Stephen Punwasi on 1/1/14.
//  Copyright (c) 2014 StephenPunwasi. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(timeout)]) {
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    } else {
        NSLog(@"Error on timeout!");
    }
    
}

#pragma mark - Helper Methods

-(void)timeout {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
