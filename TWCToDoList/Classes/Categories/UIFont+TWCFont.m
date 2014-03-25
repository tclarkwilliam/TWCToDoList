//
//  UIFont+TWCFont.m
//  TWCToDoList
//
//  Created by Tom on 25/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "UIFont+TWCFont.h"

@implementation UIFont (TWCFont)

+ (UIFont *)twc_genericFontOfSize:(CGFloat)size;
{
  return [UIFont fontWithName:@"Heiti TC" size:size];
}

@end
