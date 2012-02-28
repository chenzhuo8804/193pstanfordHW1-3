//
//  GraphicsView.h
//  GraphingCalculator
//
//  Created by Zhuo Chen on 1/1/12.
//  Copyright (c) 2012 UB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxesDrawer.h"
#import "Pair.h"


@class GraphicsView;





@protocol GraphicsViewDataSource
-(double)dataForValue:(GraphicsView*)graphicsView withValue:(double)value;

@end


@interface GraphicsView : UIView





@property (nonatomic, weak) IBOutlet id<GraphicsViewDataSource> dataSource;

-(void)pan:(UIPanGestureRecognizer*) gesture;  


@end
