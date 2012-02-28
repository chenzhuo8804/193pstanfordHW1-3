//
//  GraphingCalculatorViewController.m
//  GraphingCalculator
//
//  Created by Zhuo Chen on 1/1/12.
//  Copyright (c) 2012 UB. All rights reserved.
//

#import "GraphingCalculatorViewController.h"
#import "CalculatorViewController.h"
#import "GraphicsViewController.h"

@implementation GraphingCalculatorViewController



#pragma mark - View lifecycle




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
