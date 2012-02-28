//
//  GraphicsView.m
//  GraphingCalculator
//
//  Created by Zhuo Chen on 1/1/12.
//  Copyright (c) 2012 UB. All rights reserved.
//

#import "GraphicsView.h"
@interface GraphicsView()
@property (nonatomic) CGFloat scale;
@property (nonatomic) CGPoint originPoint;
@property (nonatomic,strong) NSTimer* timer;

@end





@implementation GraphicsView

@synthesize scale = _scale;
@synthesize originPoint = _originPoint;
@synthesize dataSource = _dataSource;
@synthesize timer =  _timer;



/* 
 init the view 
 */
-(void)setup{
    self.contentMode = 	UIViewContentModeRedraw;
    //self.originPoint = CGPointMake(-self.center.x, -self.center.y);
    self.originPoint = self.center;
    self.scale = 80;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self selector:@selector(showTimer:) userInfo:nil repeats:YES];
};


/* pinch gesture */
-(void)pinch:(UIPinchGestureRecognizer*)gesture{
    if(gesture.state == UIGestureRecognizerStateChanged || 
       gesture.state == UIGestureRecognizerStateEnded){
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
   // NSLog(@"pinch reached");
}

/* pan gesture */
-(void)pan:(UIPanGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateChanged ||
       gesture.state == UIGestureRecognizerStateEnded){
        CGPoint translation = [gesture translationInView:self];
        self.originPoint = CGPointMake(self.originPoint.x+translation.x, self.originPoint.y + translation.y);
        //NSLog(@"Pan->%g",translation.x);
        [gesture setTranslation:CGPointZero inView:self];
    }
    
}
                  
                

-(void)awakeFromNib{
    [self setup];
  
    
}

-(void)showTimer:(NSTimer*)timer{
    
}
                  
                



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}




-(CGFloat)scale{
    if(!_scale){
        _scale = 1;
    }
    return _scale;
}

-(void)setScale:(CGFloat)scale{
    if(scale != _scale){
        _scale = scale;
        [self setNeedsDisplay];
    }
}

-(void)setOriginPoint:(CGPoint)originPoint{
    if(originPoint.x >=0 &&
       originPoint.y >=0 &&
       originPoint.x <= self.bounds.size.width &&
       originPoint.y <= self.bounds.size.height){
        _originPoint = originPoint;
        [self setNeedsDisplay];
    }
       
}




/* Get the pixel value */
+(double)pixelValueOfPoint:(double)value withOrigin:(CGPoint)origin scale:(double)pointsPerUnit{
    double scaledOffset = value * pointsPerUnit;
    return origin.y + scaledOffset;
}


/* get the maximum value of an array
 * 1,2,-4,5   would return 5 
 */
+(double)maxAbsValueForArray:(NSArray*)array{
    double max = 0;
    for(id obj in array){
        if([obj isKindOfClass:[NSNumber class]]){
            if(ABS([obj doubleValue]) > max){
                max = [obj doubleValue];
            }
        }
    }
    return max;
}


/* Translate the Y value to graphics to graph coordination */
+(double)translateYtoGraphicsCord:(double)y withCenter:(CGPoint)centerPoint andScale:(double)scale{
    return centerPoint.y - scale*y;
}


/* Translate the X value to graphics to graph coordination */
+(double)translateXtoAxeCord:(double)x withCenter:(CGPoint)centerPoint andScale:(double)scale{
    return (x -centerPoint.x)/scale;
}


/* Draw a circle at a point */
- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES); // 360 degree (0 to 2pi) arc
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}




/* Draw the view */
-(void)drawRect:(CGRect)rect
{       
    if(self.originPoint.x == -1){
        self.originPoint = self.center;    
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    if(INFINITY == self.scale) self.scale = 1;
    [[UIColor blackColor] setStroke];
    for(int i=0;i<self.bounds.size.width*self.contentScaleFactor;i++){
        double xValue = [[self class] translateXtoAxeCord:(double)i/self.contentScaleFactor withCenter:self.originPoint andScale:self.scale];
        double yValue = [self.dataSource dataForValue:self withValue:xValue];
        yValue = [[self class] translateYtoGraphicsCord:yValue withCenter:self.originPoint andScale:self.scale];
              [self drawCircleAtPoint:CGPointMake(i/self.contentScaleFactor, yValue) withRadius:0.5/self.contentScaleFactor inContext:context];    
     } 
    CGContextStrokePath(context);
    [AxesDrawer drawAxesInRect:self.bounds originAtPoint:self.originPoint scale:self.scale];    
}

@end
