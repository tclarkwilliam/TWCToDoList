//
//  TWCToDoListAppDelegate.m
//  TWCToDoList
//
//  Created by Tom on 20/03/2014.
//  Copyright (c) 2014 Tom Clark. All rights reserved.
//

#import "TWCToDoListAppDelegate.h"

// Categories
#import "UIColor+TWCColor.h"
#import "UIFont+TWCFont.h"

// Pods
#import <MagicalRecord/CoreData+MagicalRecord.h>

// View controllers
#import "TWCToDoListTableViewController.h"

@implementation TWCToDoListAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [MagicalRecord setupCoreDataStack];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  TWCToDoListTableViewController *tableViewController = [[TWCToDoListTableViewController alloc] init];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
  self.window.rootViewController = navigationController;
  [self.window makeKeyAndVisible];
  
  [self configureAppearance];

  return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  [MagicalRecord cleanUp];
}

- (void)configureAppearance;
{
  [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                         UITextAttributeFont      : [UIFont twc_genericFontOfSize:18.f],
                                                         UITextAttributeTextColor : [UIColor blackColor]
                                                         }];
  
  [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                         UITextAttributeFont      : [UIFont twc_genericFontOfSize:14.f],
                                                         UITextAttributeTextColor : [UIColor twc_navBarButtonItemColor]
                                                         } forState:UIControlStateNormal];
}

@end
