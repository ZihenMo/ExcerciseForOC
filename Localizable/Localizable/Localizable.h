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

/*
 * 多语言
 */
#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Language"]

#import "UIColor+Tools.h"
#import "MBProgressHUD.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#endif /* Header_h */

