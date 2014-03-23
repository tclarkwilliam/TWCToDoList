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

@property (nonatomic, weak) IBOutlet UITextField *titleTextField;
@property (nonatomic, weak) IBOutlet UITextView  *descriptionTextView;
@property (nonatomic, strong)        TWCTask     *task;

@property (nonatomic, copy) void (^onCompletion)(void);
@property (nonatomic, copy) void (^onDeletion)(void);

@end
