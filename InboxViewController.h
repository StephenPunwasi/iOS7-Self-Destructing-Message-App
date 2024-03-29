//
//  InboxViewController.h
//  Ribbit
//
//  Created by Stephen Punwasi on 12/30/13.
//  Copyright (c) 2013 StephenPunwasi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface InboxViewController : UITableViewController
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) PFObject *selectedMessage;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
- (IBAction)logout:(id)sender;

@end
