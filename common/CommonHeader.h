//
//  CommonHeader.h
//  UI
//
//  Created by gshopper on 2019/7/31.
//  Copyright © 2019 mozihen. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

// --- Macro ---
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#define MZH_SCREEN_SIZE UIScreen.mainScreen.bounds.size
// --- Framework ---
#import <Masonry/Masonry.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "MBProgressHUD.h"
#import <UIImageView+WebCache.h>

// --- Global Value ---
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif


// --- Categories ---
#import "UIColor+Tools.h"
#import "UIView+Tools.h"

// --- Base Componenet ---

#import "BaseLabel.h"
#import "BaseButton.h"
#import "MZHViewController.h"

#endif /* CommonHeader_h */
