//
//  AppDelegate.h
//  DianDianPinZhuo
//
//  Created by user on 15/10/21.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMob.h"
#import "WXApi.h"
#import "ContactListViewController.h"

@class StatesViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,IChatManagerDelegate,EMChatManagerLoginDelegate>
{
    EMConnectionState _connectionState;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ContactListViewController *mainController;
@property (strong, nonatomic) UINavigationController *nav;
- (void)initRootViewController;

@end

