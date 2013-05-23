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

- (void)makeButtonRound:(UIButton*)button
{
    [button.layer setCornerRadius:(lowerButton.frame.size.width/8.0)];
    button.layer.masksToBounds = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [bSlider setValue:[UIScreen mainScreen].brightness];
    currentValue = bSlider.value;
    
    [self makeButtonRound:lowerButton];
    [self makeButtonRound:higherButton];
    [self makeButtonRound:fullButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bChanged:(id)sender {
    [UIScreen mainScreen].brightness = bSlider.value;
    currentValue = bSlider.value;
}


- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
    {
        
    }
}



// button actions

- (IBAction)bFullAct:(id)sender {
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
- (void)viewDidUnload {
    lowerButton = nil;
    higherButton = nil;
    fullButton = nil;
    [super viewDidUnload];
}
@end
