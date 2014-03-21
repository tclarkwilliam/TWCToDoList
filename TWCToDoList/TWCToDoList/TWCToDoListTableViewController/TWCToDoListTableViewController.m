//
//  TWCToDoListTableViewController.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListTableViewController.h"

// View controllers
#import "TWCToDoListEditViewController.h"

static NSString * const TWCToDoListTableViewCellIdentifier = @"Cell";

@interface TWCToDoListTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TWCToDoListTableViewController

- (void)viewDidLoad;
{
  [super viewDidLoad];
  
  self.title = @"To Do List";
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(addToDoButtonTapped)];
}

- (void)addToDoButtonTapped;
{
  TWCToDoListEditViewController *editViewController = [[TWCToDoListEditViewController alloc] init];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editViewController];
  
  editViewController.onCompletion = ^{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
  };
  
  [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TWCToDoListTableViewCellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TWCToDoListTableViewCellIdentifier];
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  return 60.f;
}

@end
