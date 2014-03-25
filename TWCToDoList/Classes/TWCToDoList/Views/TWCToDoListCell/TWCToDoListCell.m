//
//  TWCToDoListCell.m
//  TWCToDoList
//
//  Created by Tom on 22/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListCell.h"

// Categories
#import "NSDateFormatter+TWCDateFormatter.h"
#import "UIColor+TWCColor.h"

@interface TWCToDoListCell ()

@property (nonatomic, weak) IBOutlet UIButton *taskCompleteButton;
@property (nonatomic, assign)        BOOL      taskCompleteButtonSelected;

- (IBAction)taskCompleteButtonTapped:(id)sender;

@end

@implementation TWCToDoListCell

- (void)awakeFromNib;	
{
  [super awakeFromNib];
  
  self.taskCompleteButtonSelected = NO;

  [self configureUserInterface];
}

- (void)configureUserInterface;
{
  CGRect frameRect = self.taskCompleteButton.frame;
  frameRect.size = CGSizeMake(20.f, 20.f);
  self.taskCompleteButton.frame = frameRect;
  
  self.taskCompleteButton.layer.borderWidth  = 1.f;
  self.taskCompleteButton.layer.cornerRadius = 10.f;
  self.taskCompleteButton.layer.borderColor  = [[UIColor darkGrayColor] CGColor];
}

- (IBAction)taskCompleteButtonTapped:(id)sender
{
  if (!self.taskCompleteButtonSelected) {
    self.taskCompleteButton.backgroundColor = [UIColor twc_navBarButtonItemColor];
    self.titleTextlabel.textColor           = [UIColor lightGrayColor];
    self.additionalTextLabel.textColor      = [UIColor lightGrayColor];
		self.taskCompleteButtonSelected         = YES;
	} else {
    self.taskCompleteButton.backgroundColor = [UIColor clearColor];
    self.titleTextlabel.textColor           = [UIColor blackColor];
    self.additionalTextLabel.textColor      = [UIColor blackColor];
		self.taskCompleteButtonSelected         = NO;
	}
}

@end
