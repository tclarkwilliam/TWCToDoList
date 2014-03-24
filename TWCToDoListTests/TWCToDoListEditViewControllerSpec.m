//
//  TWCToDoListEditViewControllerSpec.m
//  TWCToDoList
//
//  Created by Tom on 24/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "TWCToDoListEditViewController.h"

SpecBegin(TWCToDoListEditViewControllerSpec)

describe(@"TWCToDoListEditViewControllerSpec", ^{
  
  TWCToDoListEditViewController *editViewController = [[TWCToDoListEditViewController alloc] init];
  
  it(@"is not nil when initialised", ^{
    expect(editViewController).toNot.beNil();
  });
  
  it(@"is an instance of TWCToDoListEditViewController class", ^{
    expect(editViewController).to.beInstanceOf([TWCToDoListEditViewController class]);
  });
  
  it(@"is a UIViewController subclass", ^{
    expect([editViewController class]).to.beSubclassOf([UIViewController class]);    
  });
  
});

SpecEnd