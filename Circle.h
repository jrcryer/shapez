//
//  Circle.h
//  Shapez
//
//  Created by Charlotte Pitchford on 20/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Shape.h"


@interface Circle :  Shape  
{
}

@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * radius;

@end



