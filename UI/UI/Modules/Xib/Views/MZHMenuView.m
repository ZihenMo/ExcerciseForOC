//
//  MZHMenuView.m
//  UI
//
//  Created by gshopper on 2019/8/12.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "MZHMenuView.h"


static const CGFloat kIndicatorHeight = 5.f;
static const CGFloat kIndicatorTopMargin = 5.f;
static const CGFloat kMenuInsetWidth = 30;
static const CGFloat kAnimateDuration = 0.25;
@interface MZHMenuView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) NSMutableArray <UIButton *> *menuButtons;

@property (nonatomic, assign) NSInteger lastIndex;

@end

@implementation MZHMenuView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lastIndex = NSNotFound;
        _currentIndex = NSNotFound;
        _indicatorColor = [UIColor redColor];
        _titleColor = [UIColor redColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.scrollView addSubview:self.indicator];
    [self addSubview:self.scrollView];
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    DDLogDebug(@"offset: %@", NSStringFromCGPoint(scrollView.contentOffset));
}


#pragma mark - Getter & Setter
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = self.bounds.size;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)indicator {
    if (_indicator == nil) {
        _indicator = [[UIView alloc] init];
    }
    return _indicator;
}
- (NSMutableArray<UIButton *> *)menuButtons {
    if (_menuButtons == nil) {
        _menuButtons = [NSMutableArray array];
    }
    return _menuButtons;
}

- (void)setTitleColor:(UIColor *)titleColor {
    for (UIButton *menuButton in self.menuButtons) {
        [menuButton setTitleColor:titleColor forState:UIControlStateNormal];
    }
    _titleColor = titleColor;
}
- (void)setIndicatorColor:(UIColor *)indicatorColor {
    for (UIButton *menuButton in self.menuButtons) {
        [menuButton setTitleColor:indicatorColor forState:UIControlStateSelected];
    }
    self.indicator.backgroundColor = indicatorColor;
    _indicatorColor = indicatorColor;
}

- (void)removeAllMenus {
    for (UIButton *menuButton in self.menuButtons) {
        [menuButton removeFromSuperview];
    }
}

- (void)setMenus:(NSArray<NSString *> *)menus {
    [self removeAllMenus];
    for (NSInteger i = 0; i < menus.count; ++i) {
        NSString *title = menus[i];
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.menuButtons addObject:menuButton];
        [menuButton setTitle:title forState:UIControlStateNormal];
        [menuButton setTitleColor:self.titleColor forState:UIControlStateNormal];
        [menuButton setTitleColor:self.indicatorColor forState:UIControlStateSelected];
        CGSize menuSize = [title boundingRectWithSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - kIndicatorHeight - kIndicatorTopMargin) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                                   NSFontAttributeName: menuButton.titleLabel.font
                                                                                                                                                                   } context:nil].size;
        CGFloat lastX = 0;
        if (i != 0) {
            UIButton *lastMenu = self.menuButtons[i - 1];
            lastX = CGRectGetMaxX(lastMenu.frame);
        }
        else {
            self.indicator.frame = CGRectMake(kMenuInsetWidth / 2, menuSize.height + kIndicatorTopMargin, menuSize.width, kIndicatorHeight);
            self.indicator.backgroundColor = self.indicatorColor;
        }
        CGRect menuFrame = CGRectMake(lastX, 0, menuSize.width + kMenuInsetWidth, menuSize.height);
        menuButton.frame = menuFrame;
        [menuButton addTarget:self action:@selector(selectMenuAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:menuButton];
    }
    CGFloat lastX = CGRectGetMaxX(self.menuButtons.lastObject.frame);
    if (lastX > self.bounds.size.width) {
        self.scrollView.contentSize = CGSizeMake(lastX, self.bounds.size.height);
    }
    if (menus.count > 0) {
        self.lastIndex = 0;
        self.currentIndex = 0;
    }
    _menus = menus;
}
- (void)selectMenuAction: (UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.currentIndex = [self.menuButtons indexOfObject:sender];
}
- (void)uncheckLastMenu {
    if (self.menuButtons.count > self.lastIndex && self.lastIndex != NSNotFound) {
        UIButton *lastMenuButton = self.menuButtons[self.lastIndex];
        lastMenuButton.selected = NO;
    }
}
- (void)checkMenu {
    if (self.currentIndex == NSNotFound) {
        return;
    }
    UIButton *currentMenuButton = self.menuButtons[self.currentIndex];
    currentMenuButton.selected = YES;
    CGRect currentMenuFrame = currentMenuButton.frame;
    CGRect indicatorFrame = CGRectMake(currentMenuFrame.origin.x + kMenuInsetWidth / 2, self.indicator.frame.origin.y, currentMenuFrame.size.width - kMenuInsetWidth, kIndicatorHeight);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kAnimateDuration animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.indicator.frame = indicatorFrame;
    }];
    CGFloat lastIndicatorX = self.scrollView.contentOffset.x;
    CGFloat currentIndicatorX = indicatorFrame.origin.x;
    CGFloat detalX = 0;
    CGFloat offsetX = 0; // todo: 位移算法
    detalX = fabs(lastIndicatorX - (currentIndicatorX + indicatorFrame.size.width + kMenuInsetWidth));
    
        [self.scrollView setContentOffset:CGPointMake(detalX, 0) animated:YES];
    
    
    if (self.delegate) {
        [self.delegate MenuView:self didSelect:self.currentIndex];
    }
}
- (void)setCurrentIndex:(NSInteger)currentIndex {
    self.lastIndex = _currentIndex;
    _currentIndex = currentIndex;
    [self uncheckLastMenu];
    [self checkMenu];
}
@end
