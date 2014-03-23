//
//  TWCTask.h
//  TWCToDoList
//
//  Created by Tom on 23/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TWCTask : NSManagedObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *additionalText;

@end
