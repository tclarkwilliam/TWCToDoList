//
//  TWCToDoListEditViewController.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListEditViewController.h"

@interface TWCToDoListEditViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation TWCToDoListEditViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self configureNavigationBar];
  [self configureUserInterFace];
}

- (void)configureNavigationBar;
{
  self.title = @"Add Task";
  
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
  
}

- (void)configureUserInterFace;
{
  self.textField.layer.cornerRadius = 5.f;
  self.textField.frame = CGRectMake(10, 90, 300, 45);
}

@end
