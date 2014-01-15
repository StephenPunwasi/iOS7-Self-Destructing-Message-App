//
//  EditFriendsViewController.h
//  Ribbit
//
//  Created by Stephen Punwasi on 12/31/13.
//  Copyright (c) 2013 StephenPunwasi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsViewController : UITableViewController
@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray *friends;
- (BOOL)isFriend:(PFUser *)user;

@end
