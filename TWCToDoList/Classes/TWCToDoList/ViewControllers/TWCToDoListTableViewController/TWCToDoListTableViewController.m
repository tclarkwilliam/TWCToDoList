//
//  TWCToDoListTableViewController.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListTableViewController.h"

// Categories
#import "UIColor+TWCColor.h"
#import "UIFont+TWCFont.h"

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
@property (nonatomic, strong) UILabel        *taskCompleteLabel;

@end

@implementation TWCToDoListTableViewController

- (void)viewDidLoad;
{
  [super viewDidLoad];
  
  [self configureNavigationBar];
  [self configureUserInterface];
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
  
  editViewController.title = @"Add Task";
  
  __weak typeof(self)weakSelf = self;
  editViewController.onCompletion = ^(TWCToDoListEditViewController *toDoListEditViewController){
    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
  };
  
  [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (void)configureUserInterface;
{
  self.taskCompleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 125.f, 30.f)];
  self.taskCompleteLabel.center    = self.view.center;
  self.taskCompleteLabel.text      = @"No Tasks";
  self.taskCompleteLabel.font      = [UIFont twc_genericFontOfSize:30.f];
  self.taskCompleteLabel.textColor = [UIColor twc_navBarButtonItemColor];
  [self.view addSubview:self.taskCompleteLabel];
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

  self.taskCompleteLabel.hidden = 0 < self.tasks.count;
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
  toDoListcell.dateTextLabel.text       = task.date;
  
  return toDoListcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  TWCTask *task = self.tasks[indexPath.row];
  
  TWCToDoListEditViewController *editViewController = [[TWCToDoListEditViewController alloc] init];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editViewController];
  
  __weak typeof(self)weakSelf = self;
  editViewController.onCompletion = ^(TWCToDoListEditViewController *toDoListEditViewController){
    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
  };
  
  editViewController.task = task;
  
  editViewController.title = @"Edit Task";
  
  editViewController.onDelete = ^(TWCToDoListEditViewController *toDoListEditViewController){
    
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    [weakSelf.tasks removeObjectAtIndex:indexPath.row];
    
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
