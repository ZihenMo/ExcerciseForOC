//
//  LocalCell.m
//  UI
//
//  Created by gshopper on 2019/7/29.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "LocalCell.h"
#import "WGCollectionViewLayout.h"
#import "ReviewCell.h"

static NSString * const kObserveKeyForContentSize = @"contentSize";

@interface LocalCell ()<UICollectionViewDelegate, UICollectionViewDataSource, WGCollectionViewLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet WGCollectionViewLayout *layout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLC;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LocalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layout.itemHeight = 40;
    self.layout.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.allowsSelection = YES;
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ReviewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView addObserver:self forKeyPath:kObserveKeyForContentSize options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kObserveKeyForContentSize]) {
        CGSize new = [change[NSKeyValueChangeNewKey] CGSizeValue];
        CGSize old = [change[NSKeyValueChangeOldKey] CGSizeValue];
        if (CGSizeEqualToSize(new, old)) { return; }
        self.heightLC.constant = new.height;
        if (self.updateHeightBlock) {
            self.updateHeightBlock();
        }
    }
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:kObserveKeyForContentSize];
}


- (void)bindSource:(NSArray *)dataArray {
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
}

#pragma mark - CollectView DataSource & Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BOOL isCheck = [self.dataArray[indexPath.item][@"check"] boolValue];
    cell.textLabel.text = self.dataArray[indexPath.item][@"title"];
    cell.imageView.image = [UIImage imageNamed:isCheck ? @"heart_selected" : @"heart_empty"];
    cell.textLabel.textColor = isCheck ? [UIColor redColor] : [UIColor grayColor];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WGCollectionViewLayout *)collectionViewLayout wideForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataArray[indexPath.item][@"title"];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{UIFontDescriptorNameAttribute: [UIFont systemFontOfSize:17]} context:nil];
    return rect.size.width + 28 + 24 + 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.item];
    BOOL isCheck = [dict[@"check"] boolValue];
    [self.dataArray replaceObjectAtIndex:indexPath.item withObject:@{
                                                                     @"title": dict[@"title"],
                                                                     @"check": @(!isCheck)
                                                                     }];
//    [UIView performWithoutAnimation:^{
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];  // WGLayout产生位移动画BUG
//    }];
}
#pragma mark - Getter & Setter
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
