//
//  NSDateFormatter+TWCDateFormatter.m
//  TWCToDoList
//
//  Created by Tom on 22/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "NSDateFormatter+TWCDateFormatter.h"

@implementation NSDateFormatter (TWCDateFormatter)

+ (NSDateFormatter *)twc_dateFormatter;
{
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  });
  
  return dateFormatter;
}

@end
