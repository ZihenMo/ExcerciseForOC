//
//  LocalDataTableViewController.m
//  UI
//
//  Created by gshopper on 2019/5/15.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "LocalDataTableViewController.h"
#import <objc/runtime.h>
#import <KafkaRefresh/KafkaRefresh.h>

@interface UITableView (Base)

@end

@interface UITableView (Edit)

@property (nonatomic, assign) BOOL enableCustomEditing;
@property (nonatomic, strong) NSIndexPath *editingIndexPath; // currenct editing row

@end
@implementation UITableView (Base)
+ (void)replaceMethodWithOriginSel:(SEL)origin_SEL aspectSel:(SEL)aspect_SEL{
    Method origMethod = class_getInstanceMethod(self, origin_SEL);
    Method aspectMethod = class_getInstanceMethod(self, aspect_SEL);
    BOOL didAddMethod = class_addMethod(self,origin_SEL,method_getImplementation(aspectMethod),method_getTypeEncoding(aspectMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,aspect_SEL,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, aspectMethod);
    }
}
+ (void)load{
    [self replaceMethodWithOriginSel:@selector(didMoveToSuperview) aspectSel:@selector(aspect_didMoveToSuperview)];
}

- (void)aspect_didMoveToSuperview{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self aspect_didMoveToSuperview];
}

@end

@implementation UITableView (Edit)

+ (void)load{
    [self replaceMethodWithOriginSel:@selector(layoutSubviews) aspectSel:@selector(aspect_layoutSubviews)];
}

- (void)aspect_layoutSubviews{
    if (self.enableCustomEditing) {
        [self.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
            if (cell.editing == YES) {
                self.editingIndexPath = [self indexPathForCell:cell];
            }
        }];
        if (self.editingIndexPath) {
            [self configSwipeButtons];
        }
    }
    [self aspect_layoutSubviews];
}

#pragma mark - Private methods
- (void)configSwipeButtons{
    UIButton *deleteButton = nil;
    if (@available(iOS 11, *)) {
        // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.subviews){
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]){
                // 和iOS 10的按钮顺序相反
                [subview setBackgroundColor:[UIColor colorWithRGB:0xd0021b]];
                deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
    else{
        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        UITableViewCell *tableCell = [self cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews){
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]){
                [subview setBackgroundColor:[UIColor colorWithRGB:0xd0021b]];
                deleteButton = subview.subviews[0];
                [self configDeleteButton:deleteButton];
            }
        }
    }
}

- (void)configDeleteButton:(UIButton *)deleteButton{
    if (deleteButton){
        [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [deleteButton setTitle:@"" forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"garbage"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor colorWithRGB:0xd0021b]];
    }
}

#pragma mark - Getter & Setter
- (NSIndexPath *)editingIndexPath{
    return objc_getAssociatedObject(self, @selector(editingIndexPath));
}

- (void)setEditingIndexPath:(NSIndexPath *) editingIndexPath{
    if (editingIndexPath == nil) {NSLog(@"nilllllll");}
    objc_setAssociatedObject(self, @selector(editingIndexPath), editingIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setEnableCustomEditing:(BOOL)enableCustomEditing{
    objc_setAssociatedObject(self, @selector(enableCustomEditing), @(enableCustomEditing), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)enableCustomEditing{
    return [objc_getAssociatedObject(self, @selector(enableCustomEditing)) boolValue];
}
@end

@interface UITableView (DefaultRefresh)

- (void)bindHeaderRefreshHandler:(dispatch_block_t)handler;

- (void)bindFooterRefreshHandler:(dispatch_block_t)handler;

@end
@implementation UITableView (DefaultRefresh)

- (void)bindHeaderRefreshHandler:(dispatch_block_t)handler{
    [self bindHeadRefreshHandler:handler themeColor:nil refreshStyle:KafkaRefreshStyleNative];
}

- (void)bindFooterRefreshHandler:(dispatch_block_t)handler{
    [self bindFootRefreshHandler:handler themeColor:nil refreshStyle:KafkaRefreshStyleNative];
}
@end

#pragma mark - emptyView
@interface UITableView (Empty)
@property (nonatomic, copy) NSString *emptyImageName;
@property (nonatomic, copy) NSString *emptyTitleText;
@property (nonatomic, copy) NSString *emptySubTitleText;

@property (nonatomic, assign) BOOL emptyViewIfINeedShow;

@end
static char GSEmptyViewKey;
static char GSEmptyImageNameKey;
static char GSEmptyTitleLabelTextKey;
static char GSEmptySubTitleLabelTextKey;

@interface GSEmptyView: UIView

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *subTitleLabel;
@property (nonatomic) UIImageView *imageView;

@end

@implementation UITableView (Empty)

+ (void)load{
    [self replaceMethodWithOriginSel:@selector(layoutSubviews) aspectSel:@selector(aspect_layoutSubViews)];
}

- (void)aspect_layoutSubViews{
    if (self.emptyViewIfINeedShow) {
        NSUInteger sectionCount = 1;
        NSUInteger rowCount = 0;
        
        if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sectionCount = [self.dataSource numberOfSectionsInTableView:self];
        }
        if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            rowCount = [self.dataSource tableView:self numberOfRowsInSection:0];
        }
        if (sectionCount == 0 || ((rowCount == 0 && sectionCount == 1) && self.visibleCells.count == 0)) {
            [self layoutEmptyView];
            [UIView animateWithDuration:0.3f delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.emptyView.alpha = 1;
            } completion:nil];
        }else if(self.emptyView.alpha == 1){
            self.emptyView.alpha = 0;
        }
    }
    [self aspect_layoutSubViews];
}

#pragma mark - Methods
- (void)setValueForKey:(void *)key value:(id)value{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getViewWithKey:(void *)key{
    return objc_getAssociatedObject(self, key);
}

- (void)layoutEmptyView{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    [self.emptyView setFrame:CGRectMake(0, height/5, width, height/4)];
    [self.emptyView setNeedsLayout];
    [self.emptyView layoutIfNeeded];
    [self insertSubview:self.emptyView atIndex:0];
    [self bringSubviewToFront:self.emptyView];
}

#pragma mark - Getter & Setter

- (void)setEmptyViewIfINeedShow:(BOOL)emptyViewIfINeedShow{
    [self setValueForKey:@selector(emptyViewIfINeedShow) value:@(emptyViewIfINeedShow)];
}

- (BOOL)emptyViewIfINeedShow{
    return [[self getViewWithKey:@selector(emptyViewIfINeedShow)] boolValue];
}

- (void)setEmptyImageName:(NSString *)emptyImageName{
    [self setValueForKey:&GSEmptyImageNameKey value:emptyImageName];
    [self.emptyView.imageView setImage:[UIImage imageNamed:emptyImageName]];
}

- (void)setEmptyTitleText:(NSString *)emptyTitleText{
    [self setValueForKey:&GSEmptyTitleLabelTextKey value:emptyTitleText];
    [self.emptyView.titleLabel setText:emptyTitleText];
}

- (void)setEmptySubTitleText:(NSString *)emptySubTitleText{
    [self setValueForKey:&GSEmptySubTitleLabelTextKey value:emptySubTitleText];
    [self.emptyView.subTitleLabel setText:emptySubTitleText];
}

- (GSEmptyView *)emptyView{
    GSEmptyView *emptyView = [self getViewWithKey:&GSEmptyViewKey];
    if (!emptyView) {
        emptyView = [[GSEmptyView alloc]init];
        [self setValueForKey:&GSEmptyViewKey value:emptyView];
    }
    return emptyView;
}
@end

@implementation GSEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        self.subTitleLabel = [[UILabel alloc]init];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.textColor = [UIColor randomColor];
        self.subTitleLabel.textColor = [UIColor randomColor];
        
        
        
        self.titleLabel.font = [UIFont systemFontOfSize:20.f];
        self.subTitleLabel.font = [UIFont systemFontOfSize:14.f];
        
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        self.titleLabel.numberOfLines = 0;
        self.subTitleLabel.numberOfLines = 0;
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        self.alpha = 0;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setSubViewFrame];
}

- (void)setSubViewFrame{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.height;
    [self.imageView setFrame:CGRectMake((width-height/2)/2, 0, height/2, height/2)];
    [self.titleLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), width, height/4)];
    [self.subTitleLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), width, height/4)];
}

@end



@interface LocalDataTableViewController ()

@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation LocalDataTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}


/**
 懒加载View
    可改变默认view(tableView)。
 */
//- (void)loadView {
//    UIView *view = [UIView new];
//    view.backgroundColor = UIColor.randomColor;
//    self.view = view;
//}

#pragma mark - UI
- (void)setupUI {
    self.tableView.enableCustomEditing = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addRefresh];
}

- (void)configDeleteButton:(UIButton *)deleteButton{
    if (deleteButton){
        [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [deleteButton setTitle:@"" forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"garbage"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor colorWithRGB:0xd0021b]];
    }
}
- (void)addRefresh{
    [self.tableView bindHeaderRefreshHandler:^{
//        self.currentPage = 1;
        [self.tableView.headRefreshControl beginRefreshing];
        [self loadData];
    }];
    [self.tableView bindFooterRefreshHandler:^{
//        self.currentPage += 1;
        [self.tableView.footRefreshControl beginRefreshing];
        [self loadData];
    }];
}
#pragma mark - loadData
- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < SHRT_MAX; ++i) {
            ;
        }
        for (NSInteger i = self.dataArray.count + 1; i < 40; ++i) {
            [self.dataArray addObject:@(i)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.headRefreshControl endRefreshing];
            [self.tableView.footRefreshControl endRefreshing];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        });
    });
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataArray[indexPath.row] stringValue];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self loadData];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}


#pragma mark - Getter
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
