//
//  TWCToDoListTableViewController.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListTableViewController.h"

// Models
#import "TWCTask.h"

// Pods
#import <MagicalRecord/CoreData+MagicalRecord.h>

// View controllers
#import "TWCToDoListEditViewController.h"

// Views
#import "TWCToDoListCell.h"

static NSString * const TWCToDoListTableViewCellIdentifier = @"Cell";
static NSString * const TWCToDoListCellNibName             = @"TWCToDoListCell";

@interface TWCToDoListTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *tasks;

@end

@implementation TWCToDoListTableViewController

- (void)viewDidLoad;
{
  [super viewDidLoad];
  
  [self configureNavigationBar];
  [self registerCell];
}

- (void)viewDidAppear:(BOOL)animated;
{
  [super viewDidAppear:animated];
  
  [self fetchTasks];
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
  
  __weak typeof(self)weakSelf = self;
  editViewController.onCompletion = ^{
    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
  };
  
  [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (void)registerCell;
{
  UINib *toDoListCell = [UINib nibWithNibName:TWCToDoListCellNibName bundle:nil];
  [self.tableView registerNib:toDoListCell forCellReuseIdentifier:TWCToDoListTableViewCellIdentifier];
}

- (void)fetchTasks;
{
  self.tasks = [NSMutableArray arrayWithArray:[TWCTask MR_findAll]];
  
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  TWCToDoListCell *toDoListcell = [tableView dequeueReusableCellWithIdentifier:TWCToDoListTableViewCellIdentifier];
  
  if (!toDoListcell) {
    toDoListcell = [[TWCToDoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TWCToDoListTableViewCellIdentifier];
  }
  
  TWCTask *task = self.tasks[indexPath.row];
  
  toDoListcell.titleTextlabel.text      = task.title;
  toDoListcell.additionalTextLabel.text = task.additionalText;
  
  return toDoListcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  TWCTask *task = self.tasks[indexPath.row];
  
  TWCToDoListEditViewController *editViewController = [[TWCToDoListEditViewController alloc] init];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editViewController];
  
  __weak typeof(self)weakSelf = self;
  editViewController.onCompletion = ^{
    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
  };
  
  editViewController.task = task;
  
  editViewController.onDeletion = ^{
    
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    [self.tasks removeObjectAtIndex:[indexPath row]];
    
    [task MR_deleteEntity];
    [localContext MR_saveToPersistentStoreAndWait];
    
    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  };
  
  [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  return 108.f;
}

@end
