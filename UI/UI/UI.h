//
//  Header.h
//  AutoLayout
//
//  Created by mozihen on 2019/4/1.
//  Copyright © 2019 mzh. All rights reserved.
//

#ifndef Header_h
#define Header_h
/// Masonry 去前缀
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarnning;
#endif

#import "UIColor+Tools.h"
#import "UIView+Tools.h"
#import "BaseButton.h"
#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <UIImageView+WebCache.h>

#endif /* Header_h */
