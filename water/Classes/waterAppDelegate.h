//
//  waterAppDelegate.h
//  water
//
//  Created by  Apple on 11-2-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class waterViewController;

@interface waterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    waterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet waterViewController *viewController;

@end
