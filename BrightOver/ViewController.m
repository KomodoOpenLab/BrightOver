//
//  ViewController.m
//  BrightOver
//
//  Created by Owen McGirr on 19/01/2013.
//  Copyright (c) 2013 Owen McGirr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [bSlider setValue:[UIScreen mainScreen].brightness];
    currentValue = bSlider.value;
    scanning = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scan) userInfo:nil repeats:YES];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scan { // Selector for scanning.
    if (inButton.accessibilityElementIsFocused) {
        [inButton setHighlighted:YES];
    }
    else {
        [inButton setHighlighted:NO];
    }
    if (decButton.accessibilityElementIsFocused) {
        [decButton setHighlighted:YES];
    }
    else {
        [decButton setHighlighted:NO];
    }
}

- (IBAction)bLowestAct:(id)sender {
    if (bSlider.value > 0.0) {
        currentValue = bSlider.value;
        [bSlider setValue:0.0];
        [UIScreen mainScreen].brightness = bSlider.value;
    }
    else {
        [bSlider setValue:currentValue];
        [UIScreen mainScreen].brightness = bSlider.value;
    }
    if (currentValue == 0.0) {
        [bSlider setValue:0.5];
        [UIScreen mainScreen].brightness = bSlider.value;
        currentValue = bSlider.value;
    }
}

- (IBAction)bChanged:(id)sender {
    [UIScreen mainScreen].brightness = bSlider.value;
    currentValue = bSlider.value;
}

- (IBAction)bHighestAct:(id)sender {
    if (bSlider.value < 1.0) {
        currentValue = bSlider.value;
        [bSlider setValue:1.0];
        [UIScreen mainScreen].brightness = bSlider.value;
    }
    else {
        [bSlider setValue:currentValue];
        [UIScreen mainScreen].brightness = bSlider.value;
    }
    if (currentValue == 1.0) {
        [bSlider setValue:0.5];
        [UIScreen mainScreen].brightness = bSlider.value;
        currentValue = bSlider.value;
    }
}

- (IBAction)bUpAct:(id)sender {
    [bSlider setValue:bSlider.value + 0.1];
    [UIScreen mainScreen].brightness = bSlider.value;
    currentValue = bSlider.value;
}

- (IBAction)bDownAct:(id)sender {
    [bSlider setValue:bSlider.value - 0.1];
    [UIScreen mainScreen].brightness = bSlider.value;
    currentValue = bSlider.value;
}
@end
