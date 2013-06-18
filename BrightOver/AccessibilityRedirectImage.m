//
//  AccessibilityRedirectImage.m
//  BrightOver
//
//  Created by Tom Nantais on 13-06-18.
//  Copyright (c) 2013 Owen McGirr. All rights reserved.
//

#import "AccessibilityRedirectImage.h"

extern NSString *AccessibilityElementFocusNotification;


@implementation AccessibilityRedirectImage

- (void)accessibilityElementDidBecomeFocused {
    [[NSNotificationCenter defaultCenter] postNotificationName:AccessibilityElementFocusNotification object:self userInfo:nil];
    NSLog(@"AccessibilityRedirect");
}

- (void)accessibilityElementDidLoseFocus {
    self.highlighted = NO;
}


@end
