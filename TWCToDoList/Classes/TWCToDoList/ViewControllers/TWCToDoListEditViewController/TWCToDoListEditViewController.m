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

// Models
#import "TWCTask.h"

// Pods
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface TWCToDoListEditViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIButton *deleteTaskButton;

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
  self.title = @"Task";
  
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
    self.onCompletion();
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
    self.onCompletion();
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
  CGRect frameRect = self.titleTextField.frame;
  frameRect.size.height = 45.f;
  self.titleTextField.frame = frameRect;
  
  self.titleTextField.layer.cornerRadius = 5.f;
  self.titleTextField.layer.borderWidth  = 1.f;
  self.titleTextField.layer.borderColor  = [[UIColor grayColor] CGColor];
  self.titleTextField.textColor          = [UIColor grayColor];
  
  UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
  [self.titleTextField setLeftViewMode:UITextFieldViewModeAlways];
  [self.titleTextField setLeftView:spacerView];
  
  self.descriptionTextView.layer.cornerRadius = 5.f;
  self.descriptionTextView.layer.borderWidth  = 1.f;
  self.descriptionTextView.layer.borderColor  = [[UIColor grayColor] CGColor];
  self.descriptionTextView.textColor          = [UIColor grayColor];
  
  CGRect buttonFrameRect = self.deleteTaskButton.frame;
  buttonFrameRect.size.height = 45.f;
  self.deleteTaskButton.frame = buttonFrameRect;
  self.deleteTaskButton.layer.cornerRadius = 5.f;
}

#pragma mark - Text field delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
  return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}

- (IBAction)deleteTaskButtonTapped:(id)sender
{
  if (self.onDeletion) {
    self.onDeletion();
  }
}

@end
