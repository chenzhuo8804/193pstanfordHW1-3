//
//  CalculatorViewController.h
//  Stanford-IOS5-Calculator
//
//  Created by Zhuo Chen on 11/20/11.
//  Copyright (c) 2011 UB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

/* The display for the result */
@property (weak, nonatomic) IBOutlet UILabel *display;

/* The display for the operand stack */
@property (weak, nonatomic) IBOutlet UILabel *display2;

@end
