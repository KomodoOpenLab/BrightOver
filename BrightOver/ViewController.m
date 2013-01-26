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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bChanged:(id)sender {
    [UIScreen mainScreen].brightness = bSlider.value;
}

- (IBAction)bFullAct:(id)sender {
    [bSlider setValue:1.0];
    [UIScreen mainScreen].brightness = bSlider.value;
}

- (IBAction)bUpAct:(id)sender {
    [bSlider setValue:bSlider.value + 0.1];
    [UIScreen mainScreen].brightness = bSlider.value;
}

- (IBAction)bDownAct:(id)sender {
    [bSlider setValue:bSlider.value - 0.1];
    [UIScreen mainScreen].brightness = bSlider.value;
}
@end
