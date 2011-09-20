//
//  ShapezAppDelegate.m
//  Shapez
//
//  Created by James Cryer on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "ShapezAppDelegate.h"
#import "ShapezViewController.h"
#import "UIColourTransformer.h"

@implementation ShapezAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	UIColourTransformer *transformer = [[[UIColourTransformer alloc] init] autorelease];
	[UIColourTransformer setValueTransformer:transformer forName:(NSString*)@"UIColourTransformerName"];
    // Override point for customization after app launch. 
	self.viewController.managedObjectContext = self.managedObjectContext;
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

#pragma mark -
#pragma mark Core Data

- (NSManagedObjectModel	*)managedObjectModel {

	if (managedObjectModel_) {
		return managedObjectModel_;
	}
	managedObjectModel_ = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	return managedObjectModel_;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
	if (persistentStoreCoordinator_) {
		return persistentStoreCoordinator_;
	}
	NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSURL *storeUrl = [NSURL fileURLWithPath:[dir stringByAppendingPathComponent:@"Shapeza.sqlite"]];
	
	NSError *error = nil;
	persistentStoreCoordinator_= [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
	if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	return persistentStoreCoordinator_;
}

- (NSManagedObjectContext *)managedObjectContext {

	if (managedObjectContext_) {
		return managedObjectContext_;
	}
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	
	if (coordinator) {
		managedObjectContext_ = [[NSManagedObjectContext alloc] init];
		[managedObjectContext_ setPersistentStoreCoordinator:coordinator];
	}
	return managedObjectContext_;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
