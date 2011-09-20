//
//  ShapezViewController.h
//  Shapez
//
//  Created by James Cryer on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BasicCanvasView.h"

@interface ShapezViewController : UIViewController {
	NSManagedObjectContext *managedObjectContext;
	BasicCanvasView *topView;
	BasicCanvasView *bottomView;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet BasicCanvasView *topView;
@property (nonatomic, retain) IBOutlet BasicCanvasView *bottomView;

@end

