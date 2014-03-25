//
//  TWCToDoListEditViewController.h
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWCTask;

@interface TWCToDoListEditViewController : UIViewController

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView  *descriptionTextView;
@property (nonatomic, strong) TWCTask     *task;

@property (nonatomic, copy) void (^onCompletion)(TWCToDoListEditViewController *toDoListEditViewController);
@property (nonatomic, copy) void (^onDelete)(TWCToDoListEditViewController *toDoListEditViewController);

@end
