//
//  CustomButton.m
//  BrightOver
//
//  Created by Owen McGirr on 14/03/2013.
//  Copyright (c) 2013 Owen McGirr. All rights reserved.
//

#import "CustomButton.h"

NSString *AccessibilityElementFocusNotification = @"AccessibilityElementFocusNotification";

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)accessibilityElementDidBecomeFocused {
    [[NSNotificationCenter defaultCenter] postNotificationName:AccessibilityElementFocusNotification object:self userInfo:nil];
    self.highlighted = YES;
}

- (void)accessibilityElementDidLoseFocus {
    self.highlighted = NO;
}

- (void)checkHighlight:(id)btn
{
        self.highlighted = [self accessibilityElementIsFocused];
}

@end
