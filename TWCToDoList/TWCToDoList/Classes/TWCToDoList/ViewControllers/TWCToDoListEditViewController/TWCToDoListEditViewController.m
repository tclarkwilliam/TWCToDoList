//
//  TWCToDoListEditViewController.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListEditViewController.h"

@interface TWCToDoListEditViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *titleTextField;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;

@end

@implementation TWCToDoListEditViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self configureNavigationBar];
  [self configureUserInterface];
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

@end
