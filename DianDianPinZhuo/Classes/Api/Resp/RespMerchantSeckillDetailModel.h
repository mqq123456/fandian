//
//  RespMerchantSeckillDetailModel.h
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/17.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "RespBaseModel.h"

@interface RespMerchantSeckillDetailModel : RespBaseModel
@property (nonatomic,strong) NSMutableArray *merchant;///MerchantModel

@property (nonatomic,strong) NSMutableArray *comments;//CommentModel
@property (nonatomic,strong) NSMutableArray *menus;//MenuModel

@property (nonatomic,strong) NSMutableArray *imgs;//ImagesModel

@end
