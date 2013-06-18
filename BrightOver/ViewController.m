//
//  ViewController.m
//  BrightOver
//
//  Created by Owen McGirr on 19/01/2013.
//  Copyright (c) 2013 Owen McGirr. All rights reserved.
//

#import "ViewController.h"

#define GLOW_STATE_LOW 0
#define GLOW_STATE_RAMP_UP 1
#define GLOW_STATE_HIGH 2
#define GLOW_STATE_RAMP_DOWN 3

#define GLOW_MIN_ALPHA 0.4
#define GLOW_MAX_ALPHA 1.0

//times are measured in 1/30 of a second
#define GLOW_LOW_TIME 30
#define GLOW_RAMP_UP_TIME 15
#define GLOW_HIGH_TIME 10
#define GLOW_RAMP_DOWN_TIME 15

//handy macro for determining if running on an iPad
#define IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)


@interface ViewController ()

@end

@implementation ViewController


- (void)makeButtonRound:(UIButton*)button
{
    [button.layer setCornerRadius:(button.frame.size.width/8.0)];
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
    glowImage.alpha = GLOW_MIN_ALPHA;
    nGlowState = GLOW_STATE_LOW;
    nGlowTimerTick = 0;
    [NSTimer scheduledTimerWithTimeInterval:(1.0/30.0) target:self selector:@selector(glowtimerfunc:) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AccessibilityElementFocusNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessibilityFocusChanged:) name:AccessibilityElementFocusNotification object:nil];
    [self checkInterfaceOrientation:self.interfaceOrientation];
}

-(void)accessibilityFocusChanged:(NSNotification*)notification
{
    UIControl *control = (UIControl*)[notification object];
    NSLog(@"ViewController> Accessibility focus changed");
}

-(void)glowtimerfunc:(NSTimer*)theTimer
{
    nGlowTimerTick++;
    switch (nGlowState)
    {
        case GLOW_STATE_LOW:
            if (nGlowTimerTick>=GLOW_LOW_TIME)
            {
                nGlowState = GLOW_STATE_RAMP_UP;
                nGlowTimerTick = 0;
            }
            break;
        case GLOW_STATE_RAMP_UP:
            if (nGlowTimerTick>=GLOW_RAMP_UP_TIME)
            {
                nGlowState = GLOW_STATE_HIGH;
                nGlowTimerTick = 0;
                glowImage.alpha = GLOW_MAX_ALPHA;
            }
            else
            {
                glowImage.alpha = GLOW_MIN_ALPHA + (float)nGlowTimerTick/(float)GLOW_RAMP_UP_TIME*(GLOW_MAX_ALPHA-GLOW_MIN_ALPHA);
            }
            break;
        case GLOW_STATE_HIGH:
            if (nGlowTimerTick>=GLOW_HIGH_TIME)
            {
                nGlowState = GLOW_STATE_RAMP_DOWN;
                nGlowTimerTick = 0;
            }
            break;
        case GLOW_STATE_RAMP_DOWN:
            if (nGlowTimerTick>=GLOW_RAMP_DOWN_TIME)
            {
                nGlowState = GLOW_STATE_LOW;
                nGlowTimerTick = 0;
                glowImage.alpha = GLOW_MIN_ALPHA;
            }
            else
            {
                glowImage.alpha = GLOW_MAX_ALPHA - (float)nGlowTimerTick/(float)GLOW_RAMP_DOWN_TIME*(GLOW_MAX_ALPHA-GLOW_MIN_ALPHA);
            }
            break;
    }
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

- (void)checkInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (IS_IPAD)
    {
        if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            backgroundView.frame = CGRectMake(0, 0, 1024, 748);
            backgroundView.image = [UIImage imageNamed:@"Default-Landscape.png"];
        }
        else if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {
            backgroundView.frame = CGRectMake(0, 0, 768, 1004);
            backgroundView.image = [UIImage imageNamed:@"Default.png"];
        }
    }
    else //iphone
    {
        if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            backgroundView.frame = CGRectMake(0, 0, 480, 320);
            backgroundView.image = [UIImage imageNamed:@"iphonebackground-landscape.png"];
        }
        else if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {
            backgroundView.frame = CGRectMake(0,0,320,460);
            backgroundView.image = [UIImage imageNamed:@"iphonebackground.png"];
        }
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self checkInterfaceOrientation:toInterfaceOrientation];
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
    
    [sender performSelector:@selector(checkHighlight:) withObject:sender afterDelay:0];
}

- (IBAction)bUpAct:(id)sender {
    [bSlider setValue:bSlider.value + 0.1];
    [UIScreen mainScreen].brightness = bSlider.value;
    currentValue = bSlider.value;
    [sender performSelector:@selector(checkHighlight:) withObject:sender afterDelay:0];
}

- (IBAction)bDownAct:(id)sender {
    [bSlider setValue:bSlider.value - 0.1];
    [UIScreen mainScreen].brightness = bSlider.value;
    currentValue = bSlider.value;
    [sender performSelector:@selector(checkHighlight:) withObject:sender afterDelay:0];
}
- (void)viewDidUnload {
    lowerButton = nil;
    higherButton = nil;
    fullButton = nil;
    backgroundView = nil;
    glowImage = nil;
    fullButton = nil;
    bSlider = nil;
    glowImage = nil;
    [super viewDidUnload];
}
@end
