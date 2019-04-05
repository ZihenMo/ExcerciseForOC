//
//  Header.h
//  RAC
//
//  Created by gshopper on 2019/4/2.
//  Copyright © 2019 mozihen. All rights reserved.
//

#ifndef Header_h
#define Header_h

/// Masonry 去前缀
#define MAS_SHORTHAND
#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Language"]

// -- lib --
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "MBProgressHUD.h"

// -- tools --
#import "UIColor+Tools.h"
// -- base --
#import "BaseButton.h"

#endif /* Header_h */
