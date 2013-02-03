//
//  ViewController.h
//  BrightOver
//
//  Created by Owen McGirr on 19/01/2013.
//  Copyright (c) 2013 Owen McGirr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    __weak IBOutlet UISlider *bSlider;
    float currentValue;
}
- (IBAction)bLowestAct:(id)sender;
- (IBAction)bChanged:(id)sender;
- (IBAction)bHighestAct:(id)sender;
- (IBAction)bUpAct:(id)sender;
- (IBAction)bDownAct:(id)sender;
@end
