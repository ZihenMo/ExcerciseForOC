//
//  CollectionViewController.m
//  UI
//
//  Created by gshopper on 2019/7/29.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "CollectionViewController.h"
#import "ReviewCell.h"
#import "WGCollectionViewLayout.h"

@interface CollectionViewController ()<WGCollectionViewLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    WGCollectionViewLayout *layout = [[WGCollectionViewLayout alloc] init];
//    layout.itemSize = CGSizeMake(100, 40);
//    layout.minimumLineSpacing = 2.0;
//    layout.minimumInteritemSpacing = 2.0;
    layout.itemHeight = 40.f;
    layout.delegate = self;
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView registerNib:[UINib nibWithNibName: NSStringFromClass(ReviewCell.class)  bundle:nil]forCellWithReuseIdentifier:reuseIdentifier];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    BOOL isCheck = [self.dataArray[indexPath.item][@"check"] boolValue];
    cell.textLabel.text = self.dataArray[indexPath.item][@"title"];
    cell.imageView.image = [UIImage imageNamed:isCheck ? @"heart_selected" : @"heart_empty"];
    cell.textLabel.textColor = isCheck ? [UIColor redColor] : [UIColor grayColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    NSDictionary *dict = self.dataArray[indexPath.item];
    BOOL isCheck = [dict[@"check"] boolValue];
    [self.dataArray replaceObjectAtIndex:indexPath.item withObject:@{
                                                                     @"title": dict[@"title"],
                                                                     @"check": @(!isCheck)
                                                                     }];
//    [UIView performWithoutAnimation:^{
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//    }];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WGCollectionViewLayout *)collectionViewLayout wideForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataArray[indexPath.item][@"title"];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{UIFontDescriptorNameAttribute: [UIFont systemFontOfSize:17]} context:nil];
    return rect.size.width + 28 + 24 + 10;
}

#pragma mark - Getter
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:@[@{@"title": @"title1", @"check": @0},
                                          @{@"title": @"title2", @"check": @0},
                                          @{@"title": @"title3", @"check": @0},
                                          @{@"title": @"title4", @"check": @0},
                                          @{@"title": @"title11", @"check": @0},
                                          @{@"title": @"title12", @"check": @0},
                                          @{@"title": @"title13", @"check": @0},
                                          @{@"title": @"title14", @"check": @0},
                                          @{@"title": @"title21", @"check": @0},
                                          @{@"title": @"title22", @"check": @0},
                                          @{@"title": @"title23", @"check": @0},
                                          @{@"title": @"title24", @"check": @0}
                                          ]];
    }
    return _dataArray;
}

@end
