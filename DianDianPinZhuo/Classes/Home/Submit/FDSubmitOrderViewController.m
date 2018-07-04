//
//  FDSubmitOrderViewController.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/12/29.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDSubmitOrderViewController.h"
#import "FDSubmitOrderSection00Cell.h"
#import "FDSubmitOrderSection01Cell.h"
#import "FDSubmitOrderSection02Cell.h"
#import "FDSubmitOrderSection11Cell.h"
#import "HQCouponsSelectViewController.h"
#import "FDOrderViewController.h"
#import "ChatViewController.h"
#import "VoucherModel.h"
#import "HttpOrderDiscountInfo.h"
#import "FDTicketPromptCell.h"

@interface FDSubmitOrderViewController ()<HQCouponsSelectViewControllerDelegate,UIActionSheetDelegate>


@property (nonatomic,weak)UIButton *submitBtn;

@end

@implementation FDSubmitOrderViewController
#pragma mark -
- (void)initSubmitBtn{
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenH-60-64, ScreenW, 60)];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor =[FDUtils colorWithHexString:@"ef2840"];
    [self.view addSubview:submitBtn];
    self.submitBtn =submitBtn;
    [self.view bringSubviewToFront:submitBtn];
}
- (void)loadOrderDiscountInfo{
    HttpOrderDiscountInfo *tool = [HttpOrderDiscountInfo sharedInstance];
    [tool loadOrderDiscountInfoWithMerchant_id:self.merchant_id meal_id:self.meal_id meal_date:self.kdate menu_id:self.menu_id people:self.people topic_id:self.topic_id is_bz:self.is_bz controller:self];
}
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    ///订单页流量
    [MobClick event:@"pv_order"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedJF = NO;
    self.title = @"提交订单";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initSubmitBtn];
   
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-60-64);
    [self loadOrderDiscountInfo];
    
}
#pragma mark - 提交订单
- (void)submitBtnClick{
    FDOrderViewController *order = [[FDOrderViewController alloc] init];
    order.merchant_id = self.merchant_id;
    order.merchant_name = self.merchant_name;
    order.icon = self.icon;
    order.kdate = self.kdate;
    order.kdate_desc = self.kdate_desc;
    order.people_desc = self.people_desc;
    order.meal_time = self.meal_time;
    order.price = self.price;
    order.people = self.people;
    order.meal_id = self.meal_id;
    order.menu_id = self.menu_id;
    order.topic_id = self.topic_id;
    VoucherModel *vourcher = [[VoucherModel alloc] init];
    vourcher.voucher_id = [self.model.voucher_id intValue];
    vourcher.voucher_type = self.model.voucher_type;
    order.voucherModel = vourcher;
    order.is_bz = self.is_bz;
    if (_selectedJF&&[self.integral_point integerValue] >=500) {///选择了积分
        order.integral_point = @"500";
    }else{
        order.integral_point = @"0";
        
    }
    order.activity_id = self.activity_id;
    order.topic_id = self.topic_id;
    if (self.initial_topic) {
        order.initial_topic = self.initial_topic;
    }
    order._paid = [NSString stringWithFormat:@"%.2f",[self.model.paid doubleValue]];
    [self.navigationController pushViewController:order animated:YES];
    
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        
        return 3;
    }else if (section==2){
        return 1;
    }
    if (self.topic_id) {
        return  [HQDefaultTool getTopic_tips].count;
    }else{
        return [HQDefaultTool getOrder_tips].count;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    if (section==3) {
        return 3;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0&&indexPath.section==0) {
        return 80;
    }
    if (indexPath.section==3) {
        NSString *str;
        if (self.topic_id) {
            str = [HQDefaultTool getTopic_tips][indexPath.row];
        }else{
            str = [HQDefaultTool getOrder_tips][indexPath.row];
        }
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-44, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
        return size.height+10;
        
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FDSubmitOrderSection00Cell *cell = [FDSubmitOrderSection00Cell cellWithTableView:tableView];
            cell.merchantName.text = self.merchant_name;
            
            if ([self.is_bz intValue]==1) {
                cell.price.text = [NSString stringWithFormat:@"%@",self.price];
                cell.meiren.text = @"/桌";
            }else{
                
                cell.price.text = self.price;
                cell.meiren.text = @"/人";
            }
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:self.icon] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                cell.icon.image = image;
            }];
            
            return cell;
        }else if (indexPath.row == 1){
            FDSubmitOrderSection02Cell *cell = [FDSubmitOrderSection02Cell cellWithTableView:tableView];
            cell.title.text = @"开餐时间";
            cell.price.text = [NSString stringWithFormat:@"%@ %@",self.kdate_desc,self.meal_time];
            cell.accView.hidden = YES;
            
            return cell;
            
        }else{
            FDSubmitOrderSection02Cell *cell = [FDSubmitOrderSection02Cell cellWithTableView:tableView];
            cell.title.text = @"就餐方式";
            NSString *people_desc =  [self.people_desc stringByReplacingOccurrencesOfString:@"\n"withString:@""];
            cell.price.text = people_desc;
            cell.accView.hidden = YES;
            
            return cell;
            
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            
            FDSubmitOrderSection02Cell *cell = [FDSubmitOrderSection02Cell cellWithTableView:tableView];
            if (!self.model.activity_name ||[self.model.activity_name isEqualToString:@""]) {
                cell.title.text = @"活动优惠";
            }else{
                cell.title.text = self.model.activity_name;
            }
            if (!self.model.activity_cash ||[self.model.activity_cash intValue]==0) {
                
                cell.price.text = @"暂无活动";
            }else{
                cell.price.text = [NSString stringWithFormat:@"-¥%@",self.model.activity_cash];
            }
            
            cell.accView.hidden = YES;
            
            
            return cell;
            
        }else if (indexPath.row ==1){
            
            FDSubmitOrderSection02Cell *cell = [FDSubmitOrderSection02Cell cellWithTableView:tableView];
            cell.title.text = @"抵扣券";
            if ([self.model.voucher_id intValue]==0) {
                cell.price.text = @"无抵扣券可用";
                cell.userInteractionEnabled = NO;
            }else{
                cell.userInteractionEnabled = YES;
                if ([self.model.voucher_type intValue]==1) {
                    cell.price.text = [NSString stringWithFormat:@"%@折抵扣券",self.model.discount];
                }else{
                    cell.price.text = [NSString stringWithFormat:@"%@元抵扣券",self.model.voucher_cash];
                }
                
            }
            
            
            return cell;
        }else{
            
            FDSubmitOrderSection01Cell *cell =[tableView dequeueReusableCellWithIdentifier:@"FDSubmitOrderSection01Cell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FDSubmitOrderSection01Cell" owner:self options:nil] lastObject];
            }
            
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            if (!self.model.integral_point_hint_a ||[self.model.integral_point_hint_a isEqualToString:@""]) {
                cell.time.text = @"500积分抵5元";
            }else{
                cell.time.text = self.model.integral_point_hint_a;
            }
            if (!self.model.integral_point_hint_a ||[self.model.integral_point_hint_a isEqualToString:@""]) {
                
                if ([self.model.integral_point_point intValue]<500) {
                    cell.people.text = [NSString stringWithFormat:@"现有积分%@，你的积分不够",self.model.integral_point_point];
                    
                }else{
                    cell.people.text = [NSString stringWithFormat:@"现有积分%@",self.model.integral_point_point];
                    
                }
                
            }else{
                cell.people.text = self.model.integral_point_hint_b;
            }
            
            cell.title.text = @"积分";
            cell.time.text = self.model.integral_point_hint_a;
            cell.selectImage.selected = !_selectedJF;
            if ([self.model.integral_point_point intValue]>=500) {
                cell.userInteractionEnabled = YES;
                [cell.selectImage setImage:[UIImage imageNamed:@"order_ico_yuan_dis"] forState:UIControlStateSelected];
                [cell.selectImage setImage:[UIImage imageNamed:@"order_ico_yuan_nor"] forState:UIControlStateNormal];
                cell.selectImage.hidden = NO;
            }else{
                cell.userInteractionEnabled = NO;
                [cell.selectImage setImage:[UIImage imageNamed:@"order_ico_yuan_dis"] forState:UIControlStateSelected];
                [cell.selectImage setImage:[UIImage imageNamed:@"order_ico_yuan_nor"] forState:UIControlStateNormal];
                cell.selectImage.hidden = YES;
            }
            
            cell.selectImage.selected = _selectedJF;
            
            return cell;
        }
        
        
    }else if(indexPath.section==2){
        FDSubmitOrderSection02Cell *cell = [FDSubmitOrderSection02Cell cellWithTableView:tableView];
        cell.title.text = @"总价";
        cell.price.text = [NSString stringWithFormat:@"%0.2f",floor(([self.model.paid floatValue])*100)/100];
        cell.price.textColor = [UIColor redColor];
        cell.yy.hidden = NO;
        cell.price.font = [UIFont systemFontOfSize:25];
        cell.accView.hidden = YES;
        return cell;
    }else{
        FDTicketPromptCell *cell = [FDTicketPromptCell cellWithTableView:tableView];
        if (self.topic_id) {
            cell.title.text = [HQDefaultTool getTopic_tips][indexPath.row];
            if ([[HQDefaultTool getTopic_tips][indexPath.row] hasSuffix:[HQDefaultTool getService]]) {
                NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
                heightLightDict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
                heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#666666" alpha:0.5];
                NSMutableAttributedString *attributeTitle=[[NSMutableAttributedString alloc] initWithString:[HQDefaultTool getTopic_tips][indexPath.row] attributes:heightLightDict];
                
                NSRange firshRange=[[HQDefaultTool getTopic_tips][indexPath.row] rangeOfString:[HQDefaultTool getService]];
                [attributeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:firshRange];
                [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:firshRange];
                [cell.title setAttributedText:attributeTitle];
                cell.title.userInteractionEnabled = YES;
                [cell.title addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneClick)]];
            }else{
                cell.title.userInteractionEnabled = NO;
            }

        }else{
            cell.title.text = [HQDefaultTool getOrder_tips][indexPath.row];
            if ([[HQDefaultTool getOrder_tips][indexPath.row] hasSuffix:[HQDefaultTool getService]]) {
                NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
                heightLightDict[NSFontAttributeName]=[UIFont systemFontOfSize:14];
                heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#666666" alpha:0.5];
                NSMutableAttributedString *attributeTitle=[[NSMutableAttributedString alloc] initWithString:[HQDefaultTool getOrder_tips][indexPath.row] attributes:heightLightDict];
                
                NSRange firshRange=[[HQDefaultTool getOrder_tips][indexPath.row] rangeOfString:[HQDefaultTool getService]];
                [attributeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:firshRange];
                [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:firshRange];
                [cell.title setAttributedText:attributeTitle];
                cell.title.userInteractionEnabled = YES;
                cell.userInteractionEnabled = YES;
                [cell.title addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneClick)]];
            }else{
                cell.title.userInteractionEnabled = NO;
            }
        }
        return cell;
    }
    
    
}
- (void)phoneClick{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"电话：%@",[HQDefaultTool getService]], nil];
    [sheet showInView:self.view.window];
}
#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[HQDefaultTool getService]]]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0&&indexPath.row == 1) {
        
    }
    
    if (indexPath.section == 1&&indexPath.row == 1) {
        HQCouponsSelectViewController * VC=[[HQCouponsSelectViewController alloc]init];
        
        VC.merchant_id = self.merchant_id;
        VC.meal_id = self.meal_id;
        VC.people = self.people;
        VC.delegate = self;
        
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.section == 1&&indexPath.row == 2) {
        _selectedJF = !_selectedJF;

        [self calculateSum];

    }
    
}
#pragma mark 重新选择优惠券活着积分的话客户端会自己计算价格
- (void)calculateSum{
    CGFloat sum;
    if ([self.is_bz intValue]==1) {
        if(self.xican){
            sum = [self.people intValue]*[self.price floatValue];
        }else{
            sum = [self.price floatValue];
            
        }
        
    }else{
        sum = [self.people intValue]*[self.price floatValue];
    }
    if ([self.model.voucher_type intValue]==0) {
        CGFloat vourcher_cash = [self.model.voucher_cash floatValue];
        CGFloat activity_cash = [self.model.activity_cash floatValue];
        CGFloat integral_point_deduction_cash = _selectedJF?[self.model.integral_point_deduction_cash floatValue]:0;
        
        CGFloat paid = sum-vourcher_cash -activity_cash - integral_point_deduction_cash;
        
        self.model.paid = [NSString stringWithFormat:@"%0.2f",floor(paid*100)/100];
        
    }else{
        
        CGFloat activity_cash = [self.model.activity_cash floatValue];
        CGFloat integral_point_deduction_cash = _selectedJF?[self.model.integral_point_deduction_cash floatValue]:0;
        
        CGFloat most_discount_cash = [self.model.most_discount_cash floatValue];
        //声明两个  NSDecimalNumber
        NSDecimalNumber *chengfa1 = [NSDecimalNumber decimalNumberWithString:self.model.discount];
        
        NSDecimalNumber *chengfa2 = [NSDecimalNumber decimalNumberWithString:@"100"];
        
        
        //乘法运算函数  decimalNumberByAdding
        NSDecimalNumber *chengfa = [chengfa1 decimalNumberByMultiplyingBy:chengfa2];
        
        CGFloat discount = [chengfa doubleValue]/1000;
        
        CGFloat actual_discount_cash = sum - (sum*discount);
        
        if (most_discount_cash>actual_discount_cash) {
            
            CGFloat paid = sum*discount - activity_cash - integral_point_deduction_cash;
            self.model.paid = [NSString stringWithFormat:@"%0.2f",floor(paid*100)/100];
            
        }else{
            CGFloat paid = sum - most_discount_cash - activity_cash - integral_point_deduction_cash;
            self.model.paid = [NSString stringWithFormat:@"%0.2f",floor(paid*100)/100];
            
        }
        
    }
    
    [self.tableView reloadData];

}
#pragma mark - HQCouponsSelectViewControllerDelegate
- (void)backWithVoucherModel:(VoucherModel *)voucherModel{
    ///如果是减价格的抵扣券
    self.model.voucher_type = voucherModel.voucher_type;
    self.model.discount = voucherModel.discount;
    self.model.most_discount_cash = voucherModel.most_discount_cash;
    self.model.voucher_cash = voucherModel.cash;
    self.model.voucher_id = [NSString stringWithFormat:@"%d",voucherModel.voucher_id];
    [self calculateSum];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
