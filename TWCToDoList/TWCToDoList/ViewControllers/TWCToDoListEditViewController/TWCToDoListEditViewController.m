//
//  TWCToDoListEditViewController.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListEditViewController.h"

@interface TWCToDoListEditViewController ()

@end

@implementation TWCToDoListEditViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self configureNavigationBar];
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
  
}

@end
