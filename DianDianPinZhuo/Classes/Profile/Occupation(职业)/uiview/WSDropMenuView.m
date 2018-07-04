//
//  TWDropMenuView.m
//  WLMenu
//
//  Created by 万匿里 on 15/8/5.
//  Copyright (c) 2015年 万匿里. All rights reserved.
//

#import "WSDropMenuView.h"
#import "FDOccupationCell.h"
#import "HQConst.h"
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width [[UIScreen mainScreen] bounds].size.width
#define KBgMaxHeight  Main_Screen_Height
#define KTableViewMaxHeight 300

#define KTopButtonHeight 44



@implementation WSIndexPath

+ (instancetype)twIndexPathWithColumn:(NSInteger)column
                                  row:(NSInteger)row
                                 item:(NSInteger)item
                                 rank:(NSInteger)rank{
    
    WSIndexPath *indexPath = [[self alloc] initWithColumn:column row:row item:item rank:rank];
    
    return indexPath;
}


- (instancetype)initWithColumn:(NSInteger )column
                           row:(NSInteger )row
                          item:(NSInteger )item
                          rank:(NSInteger )rank{
    
    if (self = [super init]) {
        
        self.column = column;
        self.row = row;
        self.item = item;
        self.rank = rank;
        
    }
    
    return self;
}


@end


static NSString *cellIdent = @"FDOccupationCell";

@interface WSDropMenuView ()<UITableViewDataSource,UITableViewDelegate>
{
    
    CGFloat _rightHeight;
    BOOL _isRightOpen;
    BOOL _isLeftOpen;
    
}

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *leftTableView_1;
//@property (nonatomic,strong) UITableView *leftTableView_2;

@property (nonatomic,strong) UITableView *rightTableView;

@property (nonatomic,strong) UIButton *bgButton; //背景

@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@end


@implementation WSDropMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.left_Select = 3;
        self.right_Select =4;
        [self show];
        [self _initialize];
        [self _setSubViews];
    }
    return self;
}


- (void)_initialize{
    
    _currSelectColumn = 0;
    _currSelectItem = WSNoFound;
    _currSelectRank = WSNoFound;
    _currSelectRow = WSNoFound;
    _isLeftOpen = YES;
    _isRightOpen = YES;
}


- (void)_setSubViews{
    
    [self addSubview:self.bgButton];
    [self.bgButton addSubview:self.leftTableView];
    [self.bgButton addSubview:self.leftTableView_1];
    [self.bgButton addSubview:self.rightTableView];
    
}


#pragma mark -- public fun --
- (void)reloadLeftTableView{
    
    [self.leftTableView reloadData];
}
- (void)reloadLeftTableView_1{
    
    [self.leftTableView_1 reloadData];
}

- (void)reloadRightTableView;
{
    
    [self.rightTableView reloadData];
}

#pragma mark -- getter --
- (UITableView *)leftTableView{
    
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.frame = CGRectMake(0, 0, self.bgButton.frame.size.width*0.4, [UIScreen mainScreen].bounds.size.height-64);
        _leftTableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _leftTableView;
}

- (UITableView *)leftTableView_1{
    
    if (!_leftTableView_1) {
        
        _leftTableView_1 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView_1.delegate = self;
        _leftTableView_1.dataSource = self;
        _leftTableView_1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView_1.showsHorizontalScrollIndicator = NO;
        _leftTableView_1.showsVerticalScrollIndicator = NO;
        _leftTableView_1.frame = CGRectMake( self.bgButton.frame.size.width*0.4, 0 , self.bgButton.frame.size.width*0.6, [UIScreen mainScreen].bounds.size.height-64);
        _leftTableView_1.backgroundColor = [UIColor whiteColor];
        _leftTableView_1.tableFooterView = [[UIView alloc]init];
        
        
    }
    
    return _leftTableView_1;
    
}

- (UITableView *)rightTableView{
    
    if (!_rightTableView) {
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        //        [_rightTableView registerClass:[FDOccupationCell class] forCellReuseIdentifier:cellIdent];
        _rightTableView.frame = CGRectMake(0, 0 , self.bgButton.frame.size.width, 0);
        
        
    }
    
    return _rightTableView;
    
    
}

- (UIButton *)bgButton{
    
    if (!_bgButton) {
        
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        _bgButton.frame = CGRectMake(0, KTopButtonHeight, CGRectGetWidth(self.frame), 40);
        [_bgButton addTarget:self action:@selector(bgAction:) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.clipsToBounds = YES;
        
    }
    
    return _bgButton;
}


#pragma mark -- tableViews Change -
- (void)_hiddenLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, 0, self.leftTableView.frame.size.width, 0);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x, 0, self.leftTableView_1.frame.size.width, 0);
    
    
}

- (void)_showLeftTableViews{
    
    self.leftTableView.frame = CGRectMake(self.leftTableView.frame.origin.x, 0, self.leftTableView.frame.size.width, [UIScreen mainScreen].bounds.size.height-64);
    self.leftTableView_1.frame = CGRectMake(self.leftTableView_1.frame.origin.x,0, self.leftTableView_1.frame.size.width, [UIScreen mainScreen].bounds.size.height-64);
    
}

- (void)_showRightTableView{
    
    CGFloat height = MIN(_rightHeight, KTableViewMaxHeight);
    
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, height);
}

- (void)_HiddenRightTableView{
    
    
    self.rightTableView.frame = CGRectMake(self.rightTableView.frame.origin.x, self.rightTableView.frame.origin.y, self.rightTableView.frame.size.width, 0);
}

- (void)_changeTopButton:(NSString *)string{
    
    
    if (_currSelectColumn == 0) {
        
        [self.leftButton setTitle:string forState:UIControlStateNormal];
    }
    if (_currSelectColumn == 1) {
        
        [self.rightButton setTitle:string forState:UIControlStateNormal];
    }
    
}

#pragma mark -- Action ----

- (void)buttonAction:(UIButton *)sender{
    if (self.leftButton == sender) {
        if (_isLeftOpen) {
            _isLeftOpen = !_isLeftOpen;
            [self bgAction:nil];
            return ;
        }
        _currSelectColumn = 0;
        _isLeftOpen = YES;
        _isRightOpen = NO;
        [self _HiddenRightTableView];
        
    }
    if (self.rightButton == sender) {
        
        if (_isRightOpen) {
            _isRightOpen = !_isRightOpen;
            [self bgAction:nil];
            return ;
        }
        
        _currSelectColumn = 1;
        _isRightOpen = YES;
        _isLeftOpen = NO;
        [self _hiddenLeftTableViews];
        
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Main_Screen_Width, Main_Screen_Height);
    self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, self.bounds.size.height - KTopButtonHeight);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        
        if (_currSelectColumn == 0) {
            [self _showLeftTableViews];
        }
        if (_currSelectColumn == 1) {
            
            [self _showRightTableView];
        }
    } completion:^(BOOL finished) {
        
    }];
}
- (void)show{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Main_Screen_Width, Main_Screen_Height);
    self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, self.bounds.size.height - KTopButtonHeight);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgButton.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        
        if (_currSelectColumn == 0) {
            [self _showLeftTableViews];
        }
        if (_currSelectColumn == 1) {
            
            [self _showRightTableView];
        }
    } completion:^(BOOL finished) {
        
    }];
    [self.leftTableView_1 reloadData];
    self.left_Select =0;
    FDOccupationCell *cell_pre = [self.leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.left_Pre inSection:0]];
    FDOccupationCell *cell_select = [self.leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.left_Select inSection:0]];
    _currSelectRow = 0;
    _currSelectItem = WSNoFound;
    _currSelectRank = WSNoFound;
    
    [self.leftTableView_1 reloadData];
    cell_pre.leftImage.hidden = YES;
    cell_pre.rightImage.hidden = YES;
    cell_pre.arrowView.hidden = YES;
    
    cell_select.leftImage.hidden = NO;
    cell_select.rightImage.hidden = NO;
    cell_select.arrowView.hidden = NO;
    self.left_Pre = self.left_Select;
    
    
}
- (void)bgAction:(UIButton *)sender{
    
    _isRightOpen = NO;
    _isLeftOpen = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        self.bgButton.backgroundColor = [UIColor clearColor];
        [self _hiddenLeftTableViews];
        [self _HiddenRightTableView];
        
        
    } completion:^(BOOL finished) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, Main_Screen_Width, KTopButtonHeight);
        self.bgButton.frame = CGRectMake(self.bgButton.frame.origin.x, self.bgButton.frame.origin.y, self.bounds.size.width, 0);
        
        
        
    }];
    
}


#pragma mark -- DataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    WSIndexPath *twIndexPath =[self _getTwIndexPathForNumWithtableView:tableView];
    if (tableView ==self.leftTableView) {
        
        NSInteger count =  [self.dataSource dropMenuView:self numberWithIndexPath:twIndexPath];
        if (twIndexPath.column == 1) {
            _rightHeight = count * 44.0;
        }
        return count;
    }else{
        NSInteger count =  [self.dataSource dropMenuView:self numberWithIndexPath:twIndexPath];
        if (twIndexPath.column == 1) {
            _rightHeight = count * 44.0;
        }
        return count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WSIndexPath *twIndexPath = [self _getTwIndexPathForCellWithTableView:tableView indexPath:indexPath];
    FDOccupationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"FDOccupationCell" owner:nil options:nil][0];
    }
    
    if (tableView ==self.leftTableView) {
        cell.rightImage.hidden = NO;
        cell.titleText.text =  [self.dataSource dropMenuView:self titleWithIndexPath:twIndexPath];
        if (indexPath.row==_currSelectRow) {
            self.left_Pre = _currSelectRow;
            cell.selected = YES;
            cell.leftImage.hidden = NO;
            cell.arrowView.hidden = YES;
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }else{
            cell.leftImage.hidden = YES;
            cell.arrowView.hidden = YES;
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.15];
        }
    }else{
        
        cell.titleText.text = [self.dataSource dropMenuView:self titleWithIndexPath:twIndexPath];
        if (indexPath.row==_currSelectItem) {
            if (_currSelectRow == _currSelectRank) {
                cell.leftImage.hidden = NO;
                cell.rightImage.hidden = NO;
                cell.arrowView.hidden = NO;
            }else{
                cell.leftImage.hidden = YES;
                cell.rightImage.hidden = YES;
                cell.arrowView.hidden = YES;
                
            }
            
        }else{
            cell.leftImage.hidden = YES;
            cell.rightImage.hidden = YES;
            cell.arrowView.hidden = YES;
        }
    }
    
    cell.titleText.textColor = [UIColor blackColor];
    
    cell.titleText.font = [UIFont systemFontOfSize:16];
    cell.titleText.highlightedTextColor = [UIColor blackColor];
    //    [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    
    
    
    return cell;
    
}


#pragma mark - tableView delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDOccupationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self _changeTopButton:cell.titleText.text ];
    
    if (tableView == self.leftTableView) {
        
        self.left_Select =indexPath.row;
        FDOccupationCell *cell_pre = [self.leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.left_Pre inSection:0]];
        cell_pre.contentView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.15];
        FDOccupationCell *cell_select = [self.leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.left_Select inSection:0]];
        cell_select.contentView.backgroundColor = [UIColor whiteColor];
        
        _currSelectRow = indexPath.row;
        
        [self.leftTableView_1 reloadData];
        cell_pre.leftImage.hidden = YES;
        cell_pre.rightImage.hidden = YES;
        cell_pre.arrowView.hidden = YES;
        
        cell_select.leftImage.hidden = NO;
        cell_select.rightImage.hidden = NO;
        cell_select.arrowView.hidden = YES;
        self.left_Pre = self.left_Select;
        
        //        [self.leftTableView_2 reloadData];
    }
    if (tableView == self.leftTableView_1) {
        self.right_Select =indexPath.row;
        FDOccupationCell *cell_pre1 = [self.leftTableView_1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.right_Pre inSection:0]];
        FDOccupationCell *cell_select1 = [self.leftTableView_1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.right_Select inSection:0]];
        
        _currSelectRank = WSNoFound;
        _currSelectItem = indexPath.row;
        
        //        [self.leftTableView_2 reloadData];
        cell_pre1.leftImage.hidden = YES;
        cell_pre1.rightImage.hidden = YES;
        cell_pre1.arrowView.hidden = YES;
        cell_select1.leftImage.hidden = NO;
        cell_select1.rightImage.hidden = YES;
        cell_select1.arrowView.hidden = NO;
        self.right_Pre = self.right_Select;
        [self.delegate dropMenuView:self didSelectWithIndexPath:[WSIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:_currSelectItem rank:WSNoFound]];
    }
    
    
    
    //    if (self.leftTableView_2 == tableView) {
    //
    //        [self bgAction:nil];
    //
    //    }
    if (self.rightTableView == tableView) {
        [self bgAction:nil];
    }
    
    
}



- (WSIndexPath *)_getTwIndexPathForNumWithtableView:(UITableView *)tableView{
    
    
    if (tableView == self.leftTableView) {
        
        return  [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:WSNoFound item:WSNoFound rank:WSNoFound];
        
    }
    
    if (tableView == self.leftTableView_1 && _currSelectRow != WSNoFound) {
        
        
        return [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:WSNoFound rank:WSNoFound];
    }
    
    
    if (tableView == self.rightTableView) {
        
        return [WSIndexPath twIndexPathWithColumn:1 row:WSNoFound item:WSNoFound  rank:WSNoFound];
    }
    
    
    return  0;
}

- (WSIndexPath *)_getTwIndexPathForCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.leftTableView) {
        
        return  [WSIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound rank:WSNoFound];
        
    }
    
    if (tableView == self.leftTableView_1) {
        
        
        return [WSIndexPath twIndexPathWithColumn:_currSelectColumn row:_currSelectRow item:indexPath.row rank:WSNoFound];
    }
    
    if (tableView == self.rightTableView) {
        
        return [WSIndexPath twIndexPathWithColumn:1 row:indexPath.row item:WSNoFound  rank:WSNoFound];
    }
    
    
    return  [WSIndexPath twIndexPathWithColumn:0 row:indexPath.row item:WSNoFound rank:WSNoFound];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54;
}




@end
