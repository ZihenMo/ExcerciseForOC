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
    NSDictionary *rowDict = self.shapeList[indexPath.row];
    ShapeType shapeType = [rowDict[@"shapeType"] integerValue];
    DrawType drawType = [rowDict[@"drawType"] integerValue];
    [self showCanvasWithShapeType:shapeType drawType:drawType];
}
# pragma mark - Acitons
- (void)showCanvasWithShapeType: (ShapeType)shapeType drawType: (DrawType)drawType {
    self.canvas.shapeType = shapeType;
    self.canvas.drawType = drawType;
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
        _shapeList = @[@{@"name": @"三角形", @"shapeType":@(ShapeTypeTriangle),                      @"drawType": @(DrawTypeCoreGraphic)},
                       @{@"name": @"三角形", @"shapeType":@(ShapeTypeTriangle),                      @"drawType": @(DrawTypeUIKit)},
                       @{@"name": @"圆形", @"shapeType": @(ShapeTypeCircle), @"drawType": @(DrawTypeCoreGraphic)},
                       @{@"name": @"圆形", @"shapeType": @(ShapeTypeCircle), @"drawType": @(DrawTypeUIKit)},
                       @{@"name": @"饼图", @"shapeType": @(ShapeTypePie), @"drawType": @(DrawTypeCoreGraphic)},
                       @{@"name": @"字符", @"shapeType": @(ShapeTypeString), @"drawType": @(DrawTypeCoreGraphic)},
                       @{@"name": @"图片", @"shapeType": @(ShapeTypeImage), @"drawType": @(DrawTypeCoreGraphic)},
                       @{@"name": @"图片", @"shapeType": @(ShapeTypeImage), @"drawType": @(DrawTypeUIKit)},
                       @{@"name": @"梯度和阴影", @"shapeType": @(ShapeTypeGradient), @"drawType": @(DrawTypeCoreGraphic)}];
    }
    return _shapeList;
}
@end
