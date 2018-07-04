//
//  FDConstellationView.m
//  DianDianPinZhuo
//
//  Created by user on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDConstellationView.h"
#import "HQHeadImageCell.h"

@implementation FDConstellationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    titleArray=@[@{@"title":@"白羊座",@"image":@"baw_ico_baiyang_nor",@"date":@"03/21-04/19"},@{@"title":@"金牛座",@"image":@"baw_ico_jinniu_nor",@"date":@"04/20-05/20"},@{@"title":@"双子座",@"image":@"baw_ico_shuangzi_nor",@"date":@"05/21-06/21"},@{@"title":@"巨蟹座",@"image":@"baw_ico_juxie_nor",@"date":@"06/22-07/22"},@{@"title":@"狮子座",@"image":@"baw_ico_shizi_nor",@"date":@"07/23-08/22"},@{@"title":@"处女座",@"image":@"baw_ico_chunv_nor",@"date":@"08/23-09/22"},@{@"title":@"天秤座",@"image":@"baw_ico_tiancheng_nor",@"date":@"09/23-10/23"},@{@"title":@"天蝎座",@"image":@"baw_ico_tianxie_nor",@"date":@"10/24-11/22"},@{@"title":@"射手座",@"image":@"baw_ico_sheshou_nor",@"date":@"11/23-12/21"},@{@"title":@"摩羯座",@"image":@"baw_ico_mojie_nor",@"date":@"12/22-01/19"},@{@"title":@"水瓶座",@"image":@"baw_ico_shuiping_nor",@"date":@"01/20-02/18"},@{@"title":@"双鱼座",@"image":@"baw_ico_shuangyu_nor",@"date":@"02/10-03/20"}];

    if (self) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing =  0.0f;
        layout.minimumInteritemSpacing = 0.0f;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width-40, 460) collectionViewLayout:layout];
        if (IPHONE4||IPHONE5) {
            collectionView.width = [UIScreen mainScreen].bounds.size.width-20;
        }else{
        }
        collectionView.layer.cornerRadius = 5;
        collectionView.layer.masksToBounds = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;

        [collectionView registerNib:[UINib nibWithNibName:@"HQHeadImageCell" bundle:nil] forCellWithReuseIdentifier:@"HQHeadImageCell"];
        [self addSubview:collectionView];
    }
    return self;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.delegate.constellationStr = titleArray[indexPath.row][@"title"];
    [self.delegate coverClickIndex:indexPath.row title:titleArray[indexPath.row][@"title"]];

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HQHeadImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HQHeadImageCell" forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:[titleArray[indexPath.row] objectForKey:@"image"]];
    cell.title.text = [titleArray[indexPath.row] objectForKey:@"title"];
    cell.date.text = [titleArray[indexPath.row] objectForKey:@"date"];
    if (IPHONE4||IPHONE5) {
        cell.left.constant = 15;
    }
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-40)/2, 70);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



@end
