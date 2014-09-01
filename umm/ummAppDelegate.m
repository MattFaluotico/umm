//
//  ummAppDelegate.m
//  umm
//
//  Created by Matthew Faluotico on 8/28/14.
//  Copyright (c) 2014 MPF. All rights reserved.
//

#import "ummAppDelegate.h"
#import "ummViewController.h"

@implementation ummAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"timerIsRunning"]) {
        ummViewController *view = (ummViewController*)self.window.rootViewController;
        [view populate];
    }
    
    return YES;
}
							
- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"timerIsRunning"]) {
        ummViewController *view = (ummViewController*)self.window.rootViewController;
        [view populate];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) applicationWillResignActive:(UIApplication *)application {
    ummViewController *view = (ummViewController*)self.window.rootViewController;
    [view postpone];
}

@end
