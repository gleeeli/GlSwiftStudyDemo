//
//  TestCollectionViewController.m
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2024/7/9.
//  Copyright © 2024 gleeeli. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "TestCollectionCollectionViewCell.h"

@interface TestCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray<UIColor *> *listArray;
@property (nonatomic, assign) NSInteger curIndex;
@end

@implementation TestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    [self scrollToNext];
}

- (void)scrollToNext {
    self.curIndex ++;
    
    if (self.curIndex >= [self.listArray count]) {
        self.curIndex = 0;
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.curIndex inSection:0];
    //这句iOS16无效(除非删除_collectionView.pagingEnabled = YES;)
//    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    CGFloat realOffset = self.view.frame.size.width * self.curIndex + 8.0 * self.curIndex;
    if (self.collectionView.contentOffset.x != realOffset) {
        [self.collectionView setContentOffset:CGPointMake(realOffset, 0) animated:YES];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollToNext];
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"当行个数：%ld", [self.listArray count]);
    return [self.listArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIColor *color = self.listArray[indexPath.row];
    
    TestCollectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = color;
    cell.label.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 8;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, 100);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[TestCollectionCollectionViewCell class] forCellWithReuseIdentifier:@"TestCollectionCollectionViewCell"];
    }
    
    return _collectionView;
}

- (NSArray<UIColor *> *)listArray {
    if (!_listArray) {
        _listArray = [NSArray arrayWithObjects:[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor blueColor], nil];
    }
    return _listArray;
}

@end
