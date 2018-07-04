//
//  FDMessageEditViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDMessageEditViewController.h"
#import "FDMessageEditCell.h"
#import "FDMessageEditBottonView.h"
#import "MyMessageModel.h"
#import "FDEvaluationViewController.h"
#import "HttpUserMessageDel.h"
#import "HttpMessageList.h"
@interface FDMessageEditViewController ()

@end

@implementation FDMessageEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self addTitleViewWithTitle:@"编辑"];
    self.page = 1;
    
    self.selectArray = [NSMutableArray array];
    
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-50);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    FDMessageEditBottonView *bottonView = [[[NSBundle mainBundle] loadNibNamed:@"FDMessageEditBottonView" owner:nil options:nil]lastObject];
    [bottonView.layer setShadowColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1].CGColor];//阴影的颜色
    [bottonView.layer setShadowOffset:CGSizeMake(0, 2)];// 阴影的范围
    [bottonView.layer setShadowOpacity:1];// 阴影透明度
    [bottonView.layer setShadowRadius:2];// 阴影扩散的范围控制
    
    [bottonView.selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottonView.delectBtn addTarget:self action:@selector(delectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottonView];
    
    
    [self loadMessageList:@""];
    
    [self setupDownRefresh];
    
    self.tableView.footer.hidden = YES;
    
}

- (void)loadMessageList:(NSString *)delect{
    HttpMessageList *tool = [HttpMessageList sharedInstance];
    [tool loadFristEditController:self deleteStr:delect];
    
}
#pragma mark - 加载更多
- (void)setupDownRefresh{
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserMessageList)];
}

- (void)loadMoreUserMessageList{
    HttpMessageList *tool = [HttpMessageList sharedInstance];
    [tool MJRefreshEditMoreController:self];
}

#pragma mark - 消息删除
- (void)delectBtnClick{//消息删除
    HttpUserMessageDel *tool = [HttpUserMessageDel sharedInstance];
    [tool loadDeleteMessage:self];
    
    
}
#pragma mark - 全选
- (void)selectAllBtnClick:(UIButton *)selectAllBtn{
    selectAllBtn.selected = !selectAllBtn.isSelected;
    if (selectAllBtn.selected) {
        [self.datyArray enumerateObjectsUsingBlock:^(MyMessageModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.selectArray addObject:model.my_id];
            model.isSelected = YES;
            if (stop) {
                [self.tableView reloadData];
            }
        }];
    }else{
        [self.datyArray enumerateObjectsUsingBlock:^(MyMessageModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            model.isSelected = NO;
            if (stop) {
                [self.tableView reloadData];
                [self.selectArray removeAllObjects];
            }
        }];
    }
}
#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessageModel *model = self.datyArray[indexPath.row];
    CGRect contentRect = [model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-85, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    double height=contentRect.size.height;
    if (indexPath.row!=0) {
        MyMessageModel *lastModel = self.datyArray[indexPath.row-1];
        NSDateFormatter*format=[[NSDateFormatter alloc] init];//日期转换器初始化并分配堆空间。
        
        [format setDateFormat:@"YYYY-MM-dd"];//
        
        NSDate *date=[format dateFromString:model.create_time];
        NSDate *last_date=[format dateFromString:lastModel.create_time];
        NSString *out_time=[self timePastToNow:[date timeIntervalSince1970]];
        NSString *last_time = [self timePastToNow:[last_date timeIntervalSince1970]];
        if ([out_time isEqualToString:@""]) {
            if (![model.img isEqualToString:@""]) {
                return 278+height;
            }
            return 138+height;
            
        }else {
            if (![out_time isEqualToString:last_time]) {
                if (![model.img isEqualToString:@""]) {
                    return 318+height;
                }
                return 178+height;
                
            }else{
                if (![model.img isEqualToString:@""]) {
                    return 278+height;
                }
                
                return 138+height;
            }
            
        }
        
    }else{
        
        NSDateFormatter*format=[[NSDateFormatter alloc] init];//日期转换器初始化并分配堆空间。
        
        [format setDateFormat:@"YYYY-MM-dd"];//
        
        NSDate *date=[format dateFromString:model.create_time];
        
        NSString *out_time=[self timePastToNow:[date timeIntervalSince1970]];
        
        if ([out_time isEqualToString:@""]) {
            if (![model.img isEqualToString:@""]) {
                return 278+height;
            }
            return 138+height;
            
        }else {
            if (![model.img isEqualToString:@""]) {
                return 318+height;
            }
            
            return 178+height;
            
        }
        
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    FDMessageEditCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDMessageEditCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    if (self.datyArray!=nil&&self.datyArray.count!=0) {
        MyMessageModel *model = self.datyArray[indexPath.row];
        
        if (indexPath.row!=0) {
            MyMessageModel *lastModel = self.datyArray[indexPath.row-1];
            NSDateFormatter*format=[[NSDateFormatter alloc] init];
            
            [format setDateFormat:@"YYYY-MM-dd"];
            
            NSDate *date=[format dateFromString:model.create_time];
            NSDate *last_date=[format dateFromString:lastModel.create_time];
            NSString *out_time=[self timePastToNow:[date timeIntervalSince1970]];
            NSString *last_time = [self timePastToNow:[last_date timeIntervalSince1970]];
            if ([out_time isEqualToString:@""]) {
                cell.timeH.constant = 0;
                cell.timeW.constant = 0;
                cell.timeLabel.text = @"";
                cell.view_top.constant = 10;
                
            }else {
                if (![out_time isEqualToString:last_time]) {
                    cell.timeH.constant = 24;
                    cell.timeW.constant = 65;
                    cell.timeLabel.text = out_time;
                    cell.view_top.constant = 50;
                    
                }else{
                    cell.timeH.constant = 0;
                    cell.timeW.constant = 0;
                    cell.timeLabel.text = @"";
                    cell.view_top.constant = 10;
                }
                
            }
            cell.date.text = model.create_time;
            cell.title.text = model.title;
            cell.detail.text = model.content;
            cell.nowEnvluation.text = model.hint;
            
            
        }else{//第0行
            
            NSDateFormatter*format=[[NSDateFormatter alloc] init];
            
            [format setDateFormat:@"YYYY-MM-dd"];//
            
            NSDate *date=[format dateFromString:model.create_time];
            
            NSString *out_time=[self timePastToNow:[date timeIntervalSince1970]];
            
            if ([out_time isEqualToString:@""]) {
                cell.timeH.constant = 0;
                cell.timeW.constant = 0;
                cell.timeLabel.text = @"";
                cell.view_top.constant = 10;
                
            }else {
                
                cell.timeH.constant = 24;
                cell.timeW.constant = 65;
                cell.timeLabel.text = out_time;
                cell.view_top.constant = 50;
            }
            
            
        }
        
        
        if (![model.img isEqualToString:@""]) {
            cell.imageH.constant = 130;
            [cell.contentImage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"ad_image"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                cell.contentImage.image = image;
            }];
        }else{
            cell.imageH.constant = 0;
        }
        
        cell.date.text = model.create_time;
        cell.title.text = model.title;
        cell.detail.text = model.content;
        cell.nowEnvluation.text = model.hint;
        
        cell.selectBtn.userInteractionEnabled = YES;
        cell.selectBtn.tag = indexPath.row;
        [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (model.isSelected == YES) {
            cell.selectBtn.selected = YES;
        }else{
            cell.selectBtn.selected = NO;
        }
    }
    
    
    return cell;
}

- (void)selectBtnClick:(UIButton *)selectBtn
{
    MyMessageModel *model = self.datyArray[selectBtn.tag];
    
    // 状态取反
    selectBtn.selected = !selectBtn.isSelected;
    model.isSelected = selectBtn.selected;
    
    if (selectBtn.selected ==YES) {
        [self.selectArray addObject:model.my_id];
        
    }else{
        [self.selectArray removeObject:model.my_id];
        
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyMessageModel *model = self.datyArray[indexPath.row];
    FDMessageEditCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectBtn.selected = !cell.selectBtn.selected;
    // 状态取反
    
    model.isSelected = cell.selectBtn.selected;
    
    if (cell.selectBtn.selected ==YES) {
        [self.selectArray addObject:model.my_id];
        
    }else{
        [self.selectArray removeObject:model.my_id];
        
    }
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datyArray.count;
}

/**
 *  根据时间戳的字符串，返回距离当前时间的描述
 */
- (NSString *)timePastToNow:(NSTimeInterval)secondsFrom1970
{
    NSString *stringTime;
    NSDate * date=[NSDate date];
    NSTimeInterval seconds=[date timeIntervalSince1970];
    NSTimeInterval timeDistance=seconds-secondsFrom1970;
    NSInteger aYearTime = 365 * 24 * 60 * 60;
    NSInteger halfYearTime = 182 * 24 * 60 * 60;
    NSInteger aQuarterTime = 90 * 24 * 60 * 60;
    NSInteger aMonthTime = 30 * 24 * 60 * 60;
    NSInteger aWeekTime = 7 * 24 * 60 * 60;
    
    if (timeDistance >= aYearTime) {
        stringTime = @"一年前";
    } else if(timeDistance >= halfYearTime) {
        stringTime = @"半年前";
    } else if(timeDistance >= aQuarterTime) {
        stringTime = @"一季前";
    } else if(timeDistance >= aMonthTime) {
        
        stringTime = @"一月前";
    } else if(timeDistance >= aWeekTime) {
        stringTime = @"一周前";
    } else {
        stringTime = @"";
    }
    return stringTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
