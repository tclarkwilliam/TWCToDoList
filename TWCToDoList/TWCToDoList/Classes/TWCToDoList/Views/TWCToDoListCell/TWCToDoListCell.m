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

@property (nonatomic, weak) IBOutlet UILabel *dateTextLabel;

@end

@implementation TWCToDoListCell

- (void)awakeFromNib;	
{
  [super awakeFromNib];
  
  [self configureText];
}

- (void)configureText;
{
  NSDate *currentDate = [NSDate date];
  NSDateFormatter *dateFormatter = [NSDateFormatter twc_dateFormatter];
  NSString *string = [dateFormatter stringFromDate:currentDate];
  
  self.dateTextLabel.text = string;
}

@end
