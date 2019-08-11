//
//  BaseNavigationBar.h
//  UI
//
//  Created by gshopper on 2019/7/31.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZHNavigationBar : UIView

typedef void(^MZHNavigationBarBackBlock)(void);
typedef void(^MZHNavigationBarLeftBlock)(void);
typedef void(^MZHNavigationBarRightBlock)(void);

@property (nonatomic, copy) MZHNavigationBarBackBlock backBlock;
@property (nonatomic, copy) MZHNavigationBarLeftBlock leftBlock;
@property (nonatomic, copy) MZHNavigationBarRightBlock rightBlock;

@property (nullable, nonatomic, strong) UIView *titleView;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, strong) UIView *backItem;
@property (nullable, nonatomic, copy) UIView *leftItem;
@property (nullable, nonatomic, copy) UIView *rightItem;
@property (nonatomic, strong) NSArray *leftItems;
@property (nonatomic, strong) NSArray *rightItems;


@property (nonatomic, assign) BOOL hidesBackItem;


- (instancetype)initWithTitle:(NSString *)title;

// A view controller that will be shown inside of a navigation controller can assign a UISearchController to this property to display the search controller’s search bar in its containing navigation controller’s navigation bar.
@property (nonatomic, retain, nullable) UISearchController *searchController API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);

// If this property is true (the default), the searchController’s search bar will hide as the user scrolls in the top view controller’s scroll view. If false, the search bar will remain visible and pinned underneath the navigation bar.
@property (nonatomic) BOOL hidesSearchBarWhenScrolling API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);



@end

NS_ASSUME_NONNULL_END
