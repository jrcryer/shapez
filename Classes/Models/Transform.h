//
//  Transform.h
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Canvas;

@interface Transform :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * scale;
@property (nonatomic, retain) Canvas * canvas;

+ (Transform *)initWithScale:(float)scale inContext:(NSManagedObjectContext *)context;
@end



