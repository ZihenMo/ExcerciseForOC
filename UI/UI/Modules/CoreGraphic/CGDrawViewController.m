//
//  CGDrawViewController.m
//  UI
//
//  Created by gshopper on 2019/5/14.
//  Copyright © 2019 mozihen. All rights reserved.
//

#import "CGDrawViewController.h"
#import "CanvasView.h"

@interface CGDrawViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *shapeList;
@property (nonatomic, strong) CanvasView *canvas;
@end

@implementation CGDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
}
#pragma mark - TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shapeList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.shapeList[indexPath.row][@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShapeType type = [self.shapeList[indexPath.row][@"type"] integerValue];
    [self showCanvasWithShapeType:type];
}
# pragma mark - Acitons
- (void)showCanvasWithShapeType: (ShapeType)type {
    self.canvas.type = type;
    [self.canvas setNeedsDisplay];
    self.canvas.hidden = NO;
}
#pragma mark - Getter
- (CanvasView *)canvas {
    if (_canvas == nil) {
        _canvas = [[CanvasView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_canvas];
    }
    return _canvas;
}

- (NSArray *)shapeList {
    if (_shapeList == nil) {
        _shapeList = @[@{@"name": @"三角形", @"type": @(ShapeTypeTriangle)},
                       @{@"name": @"圆形", @"type": @(ShapeTypeCircle)},
                       @{@"name": @"饼图", @"type": @(ShapeTypePie)},
                       @{@"name": @"字符", @"type": @(ShapeTypeString)},
                       @{@"name": @"图片", @"type": @(ShapeTypeImage)},
                       @{@"name": @"梯度和阴影", @"type": @(ShapeTypeGradient)}];
    }
    return _shapeList;
}
@end
