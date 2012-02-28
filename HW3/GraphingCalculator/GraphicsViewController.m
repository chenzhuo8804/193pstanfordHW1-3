//
//  GraphicsViewController.m
//  GraphingCalculator
//
//  Created by Zhuo Chen on 1/2/12.
//  Copyright (c) 2012 UB. All rights reserved.
//

#import "GraphicsViewController.h"
#import "GraphicsView.h"
#import "CalculatorBrain.h"


@interface GraphicsViewController () <GraphicsViewDataSource>
@property (nonatomic,weak) IBOutlet GraphicsView* graphicsView;
@property (nonatomic,strong) CalculatorBrain* brain;
@property (nonatomic) double scale;
@property (nonatomic) CGPoint centerPoint;

@end


@implementation GraphicsViewController
//@synthesize ys = _ys;

@synthesize graphicsView = _graphicsView;
@synthesize data = _data;
@synthesize brain = _brain;
@synthesize stack = _stack;
@synthesize scale = _scale;
@synthesize centerPoint = _centerPoint;



-(void)awakeFromNib{
    
    }


-(void)setStack:(id)stack{
    if([stack isKindOfClass:[NSMutableArray class]]){
        //NSLog(@" GVC ->Size of the Array %i",[stack count]);
        for( id object in stack){
            NSLog(@"%@",object);
        }
    }
    if(stack) _stack = stack;
}




-(void)setGraphicsView:(GraphicsView *)graphicsView{
    _graphicsView = graphicsView;
    self.graphicsView.dataSource = self;
    [self.graphicsView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.graphicsView action:@selector(pinch:)]];
    [self.graphicsView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self.graphicsView action:@selector(pan:)]];
}







-(NSMutableArray*) data{
  //  NSLog(@"Reached");
    if(!_data){        
        
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

-(void)updataData:(NSArray*)bounds{
    
}

-(double)dataForValue:(GraphicsView*)graphicsView withValue:(double)value{
 //   NSLog([NSString stringWithFormat:@"GVC->Size of %i",[self.stack count]]);
    
/*    for(id object in self.stack){
        if([object isKindOfClass:[NSString class]] &&
           [object isEqual:@"a"]){
            [self.stack replaceObjectAtIndex:[self.stack indexOfObject:object ] withObject:[NSNumber numberWithDouble:value]];
        }
    }  */
    id stack1 = [self.stack mutableCopy];
    if([stack1 isKindOfClass:[NSMutableArray class]]){
        for(int i=0;i<[stack1 count];i++){
            if([[stack1 objectAtIndex:i] isKindOfClass:[NSString class]] &&
               [[stack1 objectAtIndex:i] isEqual:@"a"]){
                [stack1 replaceObjectAtIndex:i withObject:[NSNumber numberWithDouble:value]];                  
            }
            
        }
    }
    return [CalculatorBrain popOperandOffProgramStack:stack1 usingVariableValues:nil];   
}
@end
