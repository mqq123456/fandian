//
//  FDTopicsTool.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/3/18.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "FDTopicsTool.h"
#import "FMDatabase.h"
#import "HQConst.h"
//@interface FDTopicsTool  ()
//{
//    FMDatabase *_database;
//}
//@end
static FMDatabase *_database;
@implementation FDTopicsTool

//获取单例对象
+(id)sharedInstance{
    static FDTopicsTool *dc=nil;
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
    NSString *path=[NSString stringWithFormat:@"%@/Documents/topics.sqlite",NSHomeDirectory()];
    _database =[[FMDatabase alloc]initWithPath:path];
    if(!_database.open)
    {
        MQQLog(@"数据库没有打开");
        return;
    }
    //创建数据表       " id integer primary key autoincrement not null, "表示id的整数主键自动增量不空
    //    数据库创建命令
    NSString *sql= @"create table if not exists topics(status)";
    BOOL b=[_database executeUpdate:sql];
    if(!b)
    {
        MQQLog(@"数据表创建失败");
    }

    
}

- (NSArray *)topics
{
    // 根据请求参数生成对应的查询SQL语句
    
    NSString *sql=@"select * from topics";
    FMResultSet *resultSet=[_database executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (resultSet.next)
    {
        NSData *statusData = [resultSet objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    
    return statuses;
}

- (void)saveStatuses:(NSArray *)statuses
{
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    [_database executeUpdate:@"delete from topics"];
    for (NSDictionary *status in statuses) {
        // NSDictionary --> NSData

        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_database executeUpdateWithFormat:@"insert into topics(status) values (%@);", statusData];
    }
}
@end

