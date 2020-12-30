//
//  AppDelegate.m
//  JLPopAlertDemo
//
//  Created by xuqinqiang on 2020/12/30.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ViewController *mainVC = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
    return YES;
}


@end
