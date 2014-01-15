//
//  InboxViewController.m
//  Ribbit
//
//  Created by Stephen Punwasi on 12/30/13.
//  Copyright (c) 2013 StephenPunwasi. All rights reserved.
//

#import "InboxViewController.h"
#import "ImageViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    } else
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipientsIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            //We found the message!!!
            self.messages = objects;
            [self.tableView reloadData];
            NSLog(@"%d", [self.messages count]);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messages count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else {
        //File type is video
        PFFile *videoFile = [self.selectedMessage objectForKey:@"file"];
        NSURL *fileURL = [NSURL URLWithString:videoFile.url];
        self.moviePlayer.contentURL = fileURL;
        [self.moviePlayer prepareToPlay];
        [self.moviePlayer thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        //Add to view controller so we can see it
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES];
    }
    //Delete it!!!
    NSMutableArray *recipientsIds = [NSMutableArray arrayWithArray:[self.selectedMessage objectForKey:@"recipientsIds"]];
    NSLog(@"Recipients: %@", recipientsIds);
    if ([recipientsIds count] == 1){
        //Last Recipient - delete
        [self.selectedMessage deleteInBackground];
    }
    else {
        //Remove the recipient and save it
        [recipientsIds removeObject:[[PFUser currentUser] objectId]];
        [self.selectedMessage setObject:recipientsIds forKey:@"recipientsIds"];
        [self.selectedMessage saveInBackground];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Cell Configuration
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    NSString *fileType = [message objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    
    return cell;
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]){
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    } else if ([segue.identifier isEqualToString:@"showImage"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        ImageViewController *imageViewController = (ImageViewController *) segue.destinationViewController;
        imageViewController.message = self.selectedMessage;
    }
}
@end
