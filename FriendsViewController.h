//
//  FriendsViewController.h
//  Ribbit
//
//  Created by Stephen Punwasi on 12/31/13.
//  Copyright (c) 2013 StephenPunwasi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface FriendsViewController : UITableViewController
@property (strong, nonatomic) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;
@end
