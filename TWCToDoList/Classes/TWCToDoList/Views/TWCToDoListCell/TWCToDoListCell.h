//
//  TWCToDoListCell.h
//  TWCToDoList
//
//  Created by Tom on 22/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWCToDoListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleTextlabel;
@property (nonatomic, weak) IBOutlet UILabel *additionalTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateTextLabel;

@end
