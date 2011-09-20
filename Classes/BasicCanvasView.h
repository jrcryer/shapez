//
//  BasicCanvasView.h
//  Shapez
//
//  Created by James Cryer on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Canvas.h"


@interface BasicCanvasView : UIView {
	Canvas *canvas;
}

@property (nonatomic, retain) Canvas *canvas;

- (float)scale;
@end
