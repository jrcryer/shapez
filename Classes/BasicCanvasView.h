//
//  BasicCanvasView.h
//  Shapez
//
//  Created by James Cryer on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BasicCanvasView : UIView {
	NSManagedObject *canvas;
}

@property (nonatomic, retain) NSManagedObject *canvas;

- (float)scale;
@end
