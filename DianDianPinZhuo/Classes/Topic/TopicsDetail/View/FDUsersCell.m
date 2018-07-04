//
//  FDUsersCell.m
//  DianDianPinZhuo
//
//  Created by HeQin on 16/4/11.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDUsersCell.h"
#import "FDTopicDetailUserHeadView.h"
#import "FDTopicUsersView.h"
#import "MemberModel.h"
#import "FDUsersFrame.h"
#import "HQConst.h"
@interface FDUsersCell()
@property (nonatomic, weak) FDTopicUsersView *photosView;
@property (nonatomic, weak) UIView *headView;
@property (nonatomic, weak) UIView *gapView;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *people;
@property (nonatomic, weak) UILabel *people_desc;
@end
@implementation FDUsersCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"FDUsersCell";
    FDUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FDUsersCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *headView = [[UIView alloc] init];
        [self.contentView addSubview:headView];
        self.headView = headView;
        UIView *gapView = [[UIView alloc] init];
        gapView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0  blue:242.0/255.0  alpha:1];
        [self.contentView addSubview:gapView];
        self.gapView = gapView;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor=[UIColor colorWithRed:233.0/255.0 green:233.0/255.0  blue:233.0/255.0  alpha:1];
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"bow_ico_xxbaoming"];
        self.icon = icon;
        [headView addSubview:icon];
        UILabel *people = [[UILabel alloc] init];
        people.textColor = FDColor(34, 34, 34, 1);
        people.font = [UIFont systemFontOfSize:17];
        [headView addSubview:people];
        self.people = people;
        
        UILabel *people_desc = [[UILabel alloc] init];
        people_desc.textColor = FDColor(153, 153, 153, 1);
        people_desc.font = [UIFont systemFontOfSize:14];
        [headView addSubview:people_desc];
        people_desc.text = @"人数已满";
        people_desc.hidden = YES;
        self.people_desc = people_desc;


        /** 头像 */
        FDTopicUsersView *photosView = [[FDTopicUsersView alloc] init];
        [self.contentView addSubview:photosView];
        
        self.photosView = photosView;
    }
    return self;
}

-(void)setUsersFrame:(FDUsersFrame *)usersFrame{
    _usersFrame = usersFrame;
    [self setupFrame];
    
    /** 配图 */
    if (usersFrame.status.count>0) {
        self.photosView.frame = usersFrame.photosViewF;
        self.photosView.photos = usersFrame.status;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
 
    NSString *content  = [NSString stringWithFormat:@"%@人预订",usersFrame.joinPeople];
    NSMutableDictionary *heightLightDict=[NSMutableDictionary dictionary];
    heightLightDict[NSForegroundColorAttributeName]=[FDUtils colorWithHexString:@"#222222"];
    NSMutableAttributedString *attributeTitle=[[NSMutableAttributedString alloc] initWithString:content attributes:heightLightDict];
    NSRange firshRange=[content rangeOfString:@"人预订"];
    [attributeTitle addAttribute:NSForegroundColorAttributeName value:[FDUtils colorWithHexString:@"#666666"] range:firshRange];
    [self.people setAttributedText:attributeTitle];
    if (usersFrame.left_seat) {
        self.people_desc.hidden = NO;
    }else{
        self.people_desc.hidden = YES;
    }
    
}
- (void)setupFrame{
    
    self.icon.frame = self.usersFrame.iconF;
    self.headView.frame = self.usersFrame.headViewF;
    self.gapView.frame = self.usersFrame.gapViewF;
    self.lineView.frame = self.usersFrame.lineViewF;
    self.people.frame = self.usersFrame.peopleF;
    self.people_desc.frame = self.usersFrame.people_descF;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
