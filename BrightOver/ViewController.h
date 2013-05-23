//
//  ViewController.h
//  BrightOver
//
//  Created by Owen McGirr on 19/01/2013.
//  Copyright (c) 2013 Owen McGirr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "CustomButton.h"

@interface ViewController : UIViewController
{
	
	
	// outlets
	
    __weak IBOutlet UISlider *bSlider;
    __weak IBOutlet CustomButton *lowerButton;
    __weak IBOutlet CustomButton *higherButton;
    __weak IBOutlet CustomButton *fullButton;
	// variables
	
    float currentValue;
	
	
}


// actions

- (IBAction)bChanged:(id)sender;
- (IBAction)bFullAct:(id)sender;
- (IBAction)bUpAct:(id)sender;
- (IBAction)bDownAct:(id)sender;


@end
