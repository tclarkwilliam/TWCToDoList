//
//  TWCTaskSpec.m
//  TWCToDoList
//
//  Created by Tom on 24/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "TWCTask.h"

SpecBegin(TWCTask)

describe(@"TWCTask", ^{
  
  TWCTask *task = [[TWCTask alloc] init];
  
  it(@"is not nil when initialised", ^{
    expect(task).toNot.beNil();
  });
  
  it(@"is an NSManagedObject subclass", ^{
    expect([task class]).to.beSubclassOf([NSManagedObject class]);
  });
  
});

SpecEnd