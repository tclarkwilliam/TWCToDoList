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

@interface TWCToDoListCell ()

@property (nonatomic, weak) IBOutlet UIButton *checkButton;
@property (nonatomic, assign)        BOOL      checkButtonSelected;

- (IBAction)checkButtonTapped:(id)sender;

@end

@implementation TWCToDoListCell

- (void)awakeFromNib;	
{
  [super awakeFromNib];
  
  self.checkButtonSelected = NO;

  [self configureUserInterface];
}

- (void)configureUserInterface;
{
  CGRect frameRect = self.checkButton.frame;
  frameRect.size = CGSizeMake(20.f, 20.f);
  self.checkButton.frame = frameRect;
  
  self.checkButton.layer.borderWidth  = 1.f;
  self.checkButton.layer.cornerRadius = 10.f;
  self.checkButton.layer.borderColor  = [[UIColor grayColor] CGColor];
}

- (IBAction)checkButtonTapped:(id)sender
{
  if (!self.checkButtonSelected){
    self.checkButton.backgroundColor   = [UIColor lightGrayColor];
    self.titleTextlabel.textColor      = [UIColor grayColor];
    self.additionalTextLabel.textColor = [UIColor grayColor];
		self.checkButtonSelected           = YES;
	} else {
    self.checkButton.backgroundColor   = [UIColor clearColor];
    self.titleTextlabel.textColor      = [UIColor blackColor];
    self.additionalTextLabel.textColor = [UIColor blackColor];
		self.checkButtonSelected           = NO;
	}
}

@end
