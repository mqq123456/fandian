//
//  FDMessageViewController.m
//  DianDianPinZhuo
//
//  Created by user on 15/10/23.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDMessageViewController.h"
#import "FDMessageCell.h"
#import "FDMessageEditViewController.h"
#import "MyMessageModel.h"
#import "FDWebViewController.h"
#import "HttpMessageList.h"
#import "FDSubjectDetailViewController.h"
#import "FDMerchantDetailController.h"
#import "MerchantModel.h"
#import "FDTopics.h"

@interface FDMessageViewController ()

@end

@implementation FDMessageViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    ///我的消息页流量
    [MobClick event:@"pv_mynews"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HiddenNewMessageRemind object:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
self.navigationController.navigationBar.tintColor = [FDUtils navgationBarTintColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.haveMJRefresh = YES;
    [self.view addSubview:[FDUtils addNavBarView]];
    
    self.title = @"通知";
    //通知，消息编辑完成后刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMessageListFrist) name:RefreshFDMessageViewController object:nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message_btn_edi_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    
    [self loadMessageListFrist];
    
    self.tableView.footer.hidden = YES;
    
}

- (void)loadMessageListFrist{
    HttpMessageList *list = [HttpMessageList sharedInstance];
    [list loadFristController:self];
}
- (void)MJRefreshTop{
    HttpMessageList *list = [HttpMessageList sharedInstance];
    [list MJRefreshTopController:self];
}

- (void)MJRefreshMore{
    HttpMessageList *list = [HttpMessageList sharedInstance];
    [list MJRefreshMoreController:self];
}

#pragma mark - 编辑消息
- (void)leftClick{
    FDMessageEditViewController *edit = [[FDMessageEditViewController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}
#pragma mark - UITableViewDataSource Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyMessageModel *model = self.datyArray[indexPath.row];
    CGRect contentRect = [model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-47, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
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
    FDMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FDMessageCell" owner:nil options:nil]lastObject];
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
        
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ///点击某一个消息
    [MobClick event:@"click_mynews_news"];
    
    MyMessageModel *model = self.datyArray[indexPath.row];
    
    if ([model.page isEqualToString:@"merchant_detail"]) {//根据不同的page跳转不同 页面
        FDMerchantDetailController *detail = [[FDMerchantDetailController alloc] init];
        MerchantModel *merchantModel = [[MerchantModel alloc] init];
        merchantModel.merchant_id = [model.param intValue];
        detail.model = merchantModel;
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local = @"1";
        [self.navigationController pushViewController:detail animated:YES];
        return;
    }
    if ([model.page isEqualToString:@"topic_detail"]) {//根据不同的page跳转不同 页面
        FDSubjectDetailViewController *detail = [[FDSubjectDetailViewController alloc] init];
        FDTopics *modelTopic = [[FDTopics alloc] init];
        modelTopic.topic_id = model.param;
        detail.model = modelTopic;
        detail.latString = [HQDefaultTool getLat];
        detail.lngString = [HQDefaultTool getLng];
        detail.local_lng = [HQDefaultTool getLng];
        detail.local_lat = [HQDefaultTool getLat];
        detail.local = 1;
        [self.navigationController pushViewController:detail animated:YES];
        return;
    }
    if (![model.url isEqualToString:@""]) {
        FDWebViewController *webView = [[FDWebViewController alloc] initWithNibName:@"FDWebViewController" bundle:nil];
        webView.titleString = model.title;
        webView.url = model.url;
//        NSLog(@"url    %@",model.url);
        [self.navigationController pushViewController:webView animated:YES];
    }
    
   

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datyArray.count;
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  根据时间戳的字符串，返回距离当前时间的描述
 */
#pragma mark - 计算过去的时间
- (NSString *)timePastToNow:(NSTimeInterval)secondsFrom1970
{
    if (!secondsFrom1970) {
        return @"";
    }
    
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

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
