//
//  TWCToDoListEditViewController.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListEditViewController.h"

// Categories
#import "NSDateFormatter+TWCDateFormatter.h"
#import "UIFont+TWCFont.h"

// Models
#import "TWCTask.h"

// Pods
#import <MagicalRecord/CoreData+MagicalRecord.h>

static NSString * const TWCToDoListTableViewEditCellIdentifier = @"Cell";

@interface TWCToDoListEditViewController () <UITextFieldDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak)   IBOutlet UIButton    *deleteTaskButton;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)deleteTaskButtonTapped:(id)sender;

@end

@implementation TWCToDoListEditViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.deleteTaskButton.hidden = !self.task;
  
  [self configureNavigationBar];
  [self configureUserInterface];
  [self populateView];
}

- (void)configureNavigationBar;
{  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(cancelButtonTapped)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(doneButtonTapped)];
}

- (void)cancelButtonTapped;
{
  if (self.onCompletion) {
    self.onCompletion(self);
  }
}

- (void)doneButtonTapped;
{
  NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
  
  if (self.task) {
    self.task.title          = self.titleTextField.text;
    self.task.additionalText = self.descriptionTextView.text;
    self.task.date           = [self currentdate];
    
  } else {
    TWCTask *task = [TWCTask MR_createInContext:localContext];
    
    task.title          = self.titleTextField.text;
    task.additionalText = self.descriptionTextView.text;
    task.date           = [self currentdate];
  }
  
  [localContext MR_saveToPersistentStoreAndWait];
  
  if (self.onCompletion) {
    self.onCompletion(self);
  }
}

- (NSString *)currentdate;
{
  NSDate *currentDate = [NSDate date];
  NSDateFormatter *dateFormatter = [NSDateFormatter twc_dateFormatter];
  NSString *string = [dateFormatter stringFromDate:currentDate];
  
  return string;
}

- (void)populateView;
{
  if (self.task) {
    self.titleTextField.text      = self.task.title;
    self.descriptionTextView.text = self.task.additionalText;
  }
}

- (void)configureUserInterface;
{
  self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.f, 0.f, 310.f, 50.f)];
  self.titleTextField.placeholder  = @"Title";
  self.titleTextField.font         = [UIFont twc_genericFontOfSize:16.f];
  self.titleTextField.delegate     = self;
  
  self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(6.f, 0.f, 310.f, 150.f)];
  self.descriptionTextView.font = [UIFont twc_genericFontOfSize:14.f];
  
  CGRect buttonFrameRect = self.deleteTaskButton.frame;
  buttonFrameRect.size.height = 45.f;
  self.deleteTaskButton.frame = buttonFrameRect;
  self.deleteTaskButton.layer.cornerRadius = 5.f;
  
  UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
  [self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void)dismissKeyboard;
{
  [self.view endEditing:YES];
}

#pragma mark - Text field delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
  return [textField resignFirstResponder];
}

- (IBAction)deleteTaskButtonTapped:(id)sender
{
  [[[UIAlertView alloc] initWithTitle:@"Delete task"
                              message:@"Are you sure you want to delete this task?"
                             delegate:self
                    cancelButtonTitle:@"No"
                    otherButtonTitles:@"Yes", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
  if (alertView.cancelButtonIndex != buttonIndex) {
    if (self.onDelete) {
      self.onDelete(self);
    }
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TWCToDoListTableViewEditCellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TWCToDoListTableViewEditCellIdentifier];
  }
  
  if (0 == indexPath.section) {
    [cell.contentView addSubview:self.titleTextField];
  } else {
    [cell.contentView addSubview:self.descriptionTextView];
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  return 0 == indexPath.section ? 50.f : 150.f;
}

@end
