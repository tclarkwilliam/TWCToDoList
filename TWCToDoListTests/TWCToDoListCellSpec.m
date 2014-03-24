//
//  TWCToDoListCellSpec.m
//  TWCToDoList
//
//  Created by Tom on 24/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "TWCToDoListCell.h"

SpecBegin(TWCToDoListCellSpec)

describe(@"TWCToDoListCellSpec", ^{
  
  TWCToDoListCell *toDoListCell = [[TWCToDoListCell alloc] init];
  
  it(@"is not nil when initialised", ^{
    expect(toDoListCell).toNot.beNil();
  });
  
  it(@"is an instance of TWCToDoListCell class", ^{
    expect(toDoListCell).to.beInstanceOf([TWCToDoListCell class]);
  });
  
  it(@"is a UITableViewCell subclass", ^{
    expect([toDoListCell class]).to.beSubclassOf([UITableViewCell class]);
  });
    
});

SpecEnd