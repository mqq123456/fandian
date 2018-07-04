//
//  FDGroupDetailTool.m
//  DianDianPinZhuo
//
//  Created by lutao on 15/11/19.
//  Copyright © 2015年 fandiankeji. All rights reserved.
//

#import "FDGroupDetailTool.h"
#import "FMDatabase.h"
#import "HQConst.h"
#import "FMDatabaseAdditions.h"
#import "HQDefaultTool.h"
@interface FDGroupDetailTool ()
{
    FMDatabase *_database;
}

@end

@implementation FDGroupDetailTool

//获取单例对象
+(id)sharedInstance{
    static FDGroupDetailTool *dc=nil;
    if(dc==nil)
    {
        dc=[[[self class]alloc]init];
    }
    return dc;
}

-(id)init
{
    if(self =[super init])
    {
        [self initDatabase];
    }
    return self;
}


-(void)initDatabase
{
    //打开数据库（如果没有，则创建）
    NSString *path=[NSString stringWithFormat:@"%@/Documents/GroupDetail.sqlite",NSHomeDirectory()];
    _database =[[FMDatabase alloc]initWithPath:path];
    if(!_database.open)
    {
        MQQLog(@"数据库没有打开");
        return;
    }
    //创建数据表       " id integer primary key autoincrement not null, "表示id的整数主键自动增量不空
    //    数据库创建命令
    NSString *sql1= @"create table if not exists GroupDetail(group_id,kid,title,icon,create_time)";
    NSString *sql2= @"create table if not exists GroupJoined(group_id,kid,joined)";
    BOOL b1=[_database executeUpdate:sql1];
    BOOL b2=[_database executeUpdate:sql2];
    if(!b1)
    {
        MQQLog(@"表1创建失败");
    }
    if(!b2)
    {
        MQQLog(@"表2创建失败");
    }
    
    
}
//添加一条记录
-(void)addgroupDetail:(NSDictionary *)group group_idString:(NSString *)idString{
    
    if ([self isExistRecordWithGroupDetail:idString]) {
            MQQLog(@"已存在");
            return;
        }else{
            NSString *sql=@"insert into GroupDetail(group_id,kid,title,icon,create_time) values(?,?,?,?,?)";
            BOOL b=[_database executeUpdate:sql,[group objectForKey:@"group_id"],[group objectForKey:@"kid"],[group objectForKey:@"title"],[group objectForKey:@"icon"],[group objectForKey:@"create_time"]];
            if(!b)
            {
                MQQLog(@"插入失败");
                return ;
            }
            MQQLog(@"插入成功");
        }

    
}
//退出之后
-(void)removeFromGroup:(NSString *)idString{
    
    if ([self isExistRecordWithGroupJoined:idString]) {
        MQQLog(@"已存在");
        NSString *sql=@"delete from GroupJoined where group_id = ? and kid=?";
        BOOL b=[_database executeUpdate:sql,idString,[HQDefaultTool getKid]];
        if(!b)
        {
            MQQLog(@"移除失败");
            return ;
        }
        MQQLog(@"移除成功");
        return;
    }else{

    }
    
    
}
//添加一条记录
-(void)addGroupJoined:(NSDictionary *)group group_idString:(NSString *)idString{
    
    if ([self isExistRecordWithGroupJoined:idString]) {
        MQQLog(@"已进入");
        return;
    }else{
        MQQLog(@"没进入");
        
        [self removeFromGroup:idString];
        
        NSString *sql=@"insert into GroupJoined(group_id,kid,joined) values(?,?,?)";
        BOOL b=[_database executeUpdate:sql,[group objectForKey:@"group_id"],[group objectForKey:@"kid"],@"1"];
        if(!b)
        {
            MQQLog(@"插入失败");
            return ;
        }
        MQQLog(@"插入成功");
    }
    
    
}
//检查某是否被记录
-(BOOL)isExistRecordWithGroupDetail:(NSString *)group_id{
    NSString *sql=@"select * from GroupDetail where group_id = ?";
    FMResultSet *resultSet = [_database executeQuery:sql,[NSString stringWithFormat:@"%@",group_id]];
    int count=0;
    while ([resultSet next])
    {
        count++;
    }
    return count>0;
}


//检查某是否被记录
-(BOOL)isExistRecordWithGroupJoined:(NSString *)group_id{
    NSString *sql=@"select * from GroupJoined where group_id = ? and kid=?";
    FMResultSet *resultSet = [_database executeQuery:sql,[NSString stringWithFormat:@"%@",group_id],[HQDefaultTool getKid]];
    NSString *joinedStr;
    NSString *kidStr;
    
    while ([resultSet next])
    {
        
        joinedStr= [resultSet stringForColumn:@"joined"];
        kidStr =[resultSet stringForColumn:@"kid"];
    }
    
    if ([joinedStr isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
///移除一条数据
- (BOOL)removeSelectedHistoryGroupDetail:(NSString *)group_id{
    if ([self isExistRecordWithGroupDetail:group_id]) {
        NSString *sql=@"delete from GroupJoined where group_id = ? and kid=?";
        BOOL b=[_database executeUpdate:sql,group_id,[HQDefaultTool getKid]];
        if (!b)
        {
            MQQLog(@"删除失败");
        }else{
            MQQLog(@"删除成功");
        
        }

    }
    return YES;

}


///获取某一条群组信息
- (NSDictionary *)recordGroupDetail:(NSString *)group_id{
    NSMutableDictionary *groupDic =[NSMutableDictionary dictionary];
    
    if ([self isExistRecordWithGroupDetail:group_id]) {
         NSString *sql=@"select * from GroupDetail where group_id = ?";
         FMResultSet *resultSet = [_database executeQuery:sql,[NSString stringWithFormat:@"%@",group_id]];
        while ([resultSet next])
        {
            [groupDic setValue:[resultSet stringForColumn:@"title"] forKey:@"title"] ;
            [groupDic setValue:[resultSet stringForColumn:@"icon"] forKey:@"icon"] ;
            [groupDic setValue:[resultSet stringForColumn:@"create_time"] forKey:@"create_time"] ;
            
        }
        return groupDic;

    }
    return nil;
}
@end
