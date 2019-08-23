//
//  MZHMenuView.h
//  UI
//
//  Created by gshopper on 2019/8/12.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MZHMenuView;
@protocol MZHMenuViewDelegate <NSObject>

- (void)MenuView: (MZHMenuView *) menuView didSelect: (NSInteger)index;

@end


@interface MZHMenuView : UIView

@property (nonatomic, weak) id<MZHMenuViewDelegate> delegate;

/**
 菜单标题
 */
@property (nonatomic, strong) NSArray <NSString *> *menus;

/**
 当前索引
    若menus为空，默认为NSNotFound。否则默认为0.
 */
@property (nonatomic, assign) NSInteger currentIndex;

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;


/**
 标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;


/**
 指示器颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;


@end

NS_ASSUME_NONNULL_END
