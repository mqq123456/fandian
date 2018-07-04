//
//  HQSearchHistoryTool.m
//  DianDianPinZhuo
//
//  Created by user on 15/8/29.
//  Copyright (c) 2015年 heqinuc. All rights reserved.
//

#import "HQSearchHistoryTool.h"
#import "FMDatabase.h"
#import "SVProgressHUD.h"
#import "HQConst.h"
#import "FMDatabaseAdditions.h"
@interface HQSearchHistoryTool  ()
{
    FMDatabase *_database;
}

@end
@implementation HQSearchHistoryTool

//获取单例对象
+(id)sharedInstance{
    static HQSearchHistoryTool *dc=nil;
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
    NSString *path=[NSString stringWithFormat:@"%@/Documents/search.sqlite",NSHomeDirectory()];
    _database =[[FMDatabase alloc]initWithPath:path];
    if(!_database.open)
    {
        MQQLog(@"数据库没有打开");
        return;
    }
    //创建数据表       " id integer primary key autoincrement not null, "表示id的整数主键自动增量不空
    //    数据库创建命令
    NSString *sql= @"create table if not exists search  ("
    " id integer primary key autoincrement not null, "
    " name varchar(6000), "
    " address varchar(8000), "
    " lat varchar(8000), "
    " idString varchar(256), "
    " lng varchar(8000) "
    ");";
    BOOL b=[_database executeUpdate:sql];
    if(!b)
    {
        MQQLog(@"数据表创建失败");
    }
    
    
}

//添加一条记录
-(void)addSearchName:(AMapPOI *)poi idString:(NSString *)idString{

   // NSUInteger count = [_database intForQuery:@"select count(*) from search"];
//    if ([idString intValue]>=10) {
//        NSString *sql=@"delete from search where idString = ?";
//        BOOL b=[_database executeUpdate:sql,[NSString stringWithFormat:@"%d",[idString intValue]-10]];
//        if (!b)
//        {
//            MQQLog(@"删除失败");
//            return;
//        }else{
//            NSString *sql=@"insert into search(name,address,lat,lng,idString) values(?,?,?,?,?)";
//            BOOL b=[_database executeUpdate:sql,poi.name,poi.address,[NSString stringWithFormat:@"%.16f",poi.location.latitude],[NSString stringWithFormat:@"%.16f",poi.location.longitude],idString];
//            if(!b)
//            {
//                MQQLog(@"插入失败");
//                return ;
//            }
//            MQQLog(@"插入成功");
//        }
//    }else{
        NSString *sql=@"insert into search(name,address,lat,lng,idString) values(?,?,?,?,?)";
        BOOL b=[_database executeUpdate:sql,poi.name,poi.address,[NSString stringWithFormat:@"%.16f",poi.location.latitude],[NSString stringWithFormat:@"%.16f",poi.location.longitude],idString];
        if(!b)
        {
            MQQLog(@"插入失败");
            return ;
        }
        MQQLog(@"插入成功");
//    }
    
}

//获取记录列表
-(NSArray *)recordList{
    NSString *sql=@"select * from search order by id desc";
    FMResultSet *resultSet=[_database executeQuery:sql];
    NSMutableArray *marr=[[NSMutableArray alloc]init];
    while ([resultSet next])
    {
        AMapPOI *pois=[[AMapPOI alloc]init];
        pois.name = [resultSet stringForColumn:@"name"];
        pois.address = [resultSet stringForColumn:@"address"];
        AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:[[resultSet stringForColumn:@"lat"] doubleValue] longitude:[[resultSet stringForColumn:@"lng"] doubleValue]];
        pois.location = point;
        [marr addObject:pois];
    }

    return marr;
}

//检查某是否被记录
-(BOOL)isExistRecordWithSearchName:(NSString *)name{
    NSString *sql=@"select * from search where name = ?";
    FMResultSet *resultSet = [_database executeQuery:sql,[NSString stringWithFormat:@"%@",name]];
    int count=0;
    while ([resultSet next])
    {
        count++;
    }
    return count>0;
}

//删除记录
-(BOOL)removeSelectedHistoryWithName:(NSString *)name
{
    NSString *sql=@"delete from search where name = ?";
    BOOL b=[_database executeUpdate:sql,name];
    if (!b)
    {
        MQQLog(@"删除失败");
    }
    return YES;
}


@end
