

#import "AppDelegate.h"
#import "DemoTableViewController.h"

@implementation AppDelegate


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ****************************************************************************
    // Fill in with your Parse and Twitter credentials. Don't forget to add your
    // Facebook id in Info.plist:
    // ****************************************************************************
    [Parse setApplicationId:@"p39KF5CwUlOUB5GyKUKjmc7vobjC9D5IINNSI4ml" clientKey:@"KlEhuG3lfJSUIgoQAySkfBgUOYL4UksGQCVbfsVV"];
//    [PFFacebookUtils initializeFacebook];
/*  [PFTwitterUtils initializeWithConsumerKey:@"your_twitter_consumer_key" consumerSecret:@"your_twitter_consumer_secret"];*/
    
    // Set default ACLs
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    self.viewController = [[rootViewViewController alloc] initWithNibName:@"rootViewViewController" bundle:nil];
    self.secondView = [[DepsViewContoller alloc] initWithNibName:@"DepsViewContoller" bundle:nil];
    
    
    // Assigning with Navigation for push / pop purpose
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.navigationController1 = [[UINavigationController alloc] initWithRootViewController:self.secondView];
    
    UIImage *navBackgroundImage = [UIImage imageNamed:@"NavBar"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    /*
    UIImage *backButton = [UIImage imageNamed:@"backArrow"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    */
    self.tabBarController = [[UITabBarController alloc] init];
    
    NSArray *controllers = [NSArray arrayWithObjects:self.navigationController,self.navigationController1, nil];
    self.tabBarController.viewControllers = controllers;

    UITabBarItem *tabBarItem1 = [self.tabBarController.tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [self.tabBarController.tabBar.items objectAtIndex:1];
    
    tabBarItem1.title = @"Search";
    tabBarItem2.title = @"Departments";

    [tabBarItem1 setImage:[UIImage imageNamed:@"search.png"]];
    [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"searchFilled.png"]];
    
    [tabBarItem2 setImage:[UIImage imageNamed:@"departments.png"]];
    [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"departmentsFilled.png"]];
    
    
    UIImage *tabBarBackground = [UIImage imageNamed:@"customTab.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabBarSel.png"]];
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    
    
    /*
    UIColor *tabTextColor = [UIColor colorWithRed:(51.0/255.0) green:(67.0/255.0) blue:(77.0/255.0) alpha:1.0];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       tabTextColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       tabTextColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateHighlighted];
    */
    
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
    
}

// Facebook oauth callback
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Handle an interruption during the authorization flow, such as the user clicking the home button.
    [FBSession.activeSession handleDidBecomeActive];
}

@end
