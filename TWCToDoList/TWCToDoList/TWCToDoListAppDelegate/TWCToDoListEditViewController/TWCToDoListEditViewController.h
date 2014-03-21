//
//  TWCToDoListEditViewController.h
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWCToDoListEditViewController : UIViewController

@property (nonatomic, copy) void(^onCompletion)(void);

@end
