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

// Views
#import "TWCToDoListCell.h"

static NSString * const TWCToDoListTableViewCellIdentifier = @"Cell";
static NSString * const TWCToDoListCellNibName             = @"TWCToDoListCell";

@interface TWCToDoListTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TWCToDoListTableViewController

- (void)viewDidLoad;
{
  [super viewDidLoad];
  
  [self configureNavigationBar];
  [self registerCell];
}

- (void)configureNavigationBar;
{
  self.title = @"To Do List";
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(addTaskButtonTapped)];
}

- (void)addTaskButtonTapped;
{
  TWCToDoListEditViewController *editViewController = [[TWCToDoListEditViewController alloc] init];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editViewController];
  
  editViewController.onCompletion = ^{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
  };
  
  [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (void)registerCell;
{
  UINib *toDoListCell = [UINib nibWithNibName:TWCToDoListCellNibName bundle:nil];
  [self.tableView registerNib:toDoListCell forCellReuseIdentifier:TWCToDoListTableViewCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  TWCToDoListCell *toDoListcell = [tableView dequeueReusableCellWithIdentifier:TWCToDoListTableViewCellIdentifier];
  
  if (!toDoListcell) {
    toDoListcell = [[TWCToDoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TWCToDoListTableViewCellIdentifier];
  }
  
  return toDoListcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  [self addTaskButtonTapped];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  return 108.f;
}

@end
