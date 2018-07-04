//
//  HQIMFriendsTool.m
//  DianDianPinZhuo
//
//  Created by heqinuc on 16/1/15.
//  Copyright © 2016年 fandiankeji. All rights reserved.
//

#import "HQIMFriendsTool.h"
#import "FMDatabase.h"
#import "HQConst.h"

@interface HQIMFriendsTool  ()
{
    FMDatabase *_database;
}

@end
@implementation HQIMFriendsTool

//获取单例对象
+(id)sharedInstance{
    static HQIMFriendsTool *dc=nil;
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
    NSString *path=[NSString stringWithFormat:@"%@/Documents/myFriends.sqlite",NSHomeDirectory()];
    _database =[[FMDatabase alloc]initWithPath:path];
    if(!_database.open)
    {
        MQQLog(@"数据库没有打开");
        return;
    }
    //创建数据表       " id integer primary key autoincrement not null, "表示id的整数主键自动增量不空
    //    数据库创建命令
     NSString *sql= @"create table if not exists myFriends(kid,nickname,url)";
    BOOL b=[_database executeUpdate:sql];
    if(!b)
    {
        MQQLog(@"数据表创建失败");
    }
    
    
}

//添加一条记录
-(void)addFriendsName:(UsersModel *)user idString:(NSString *)kid{
    
        NSString *sql=@"delete from myFriends where kid = ?";
        BOOL b=[_database executeUpdate:sql,kid];
        if (!b)
        {
            MQQLog(@"删除失败");
            return;
        }else{
            NSString *sql=@"insert into myFriends(kid,nickname,url) values(?,?,?)";
            BOOL b=[_database executeUpdate:sql,user.kid,user.nickname,user.url];
            if(!b)
            {
                MQQLog(@"插入失败");
                return ;
            }
            MQQLog(@"插入成功");
        }

    
}

//获取记录列表
-(NSArray *)recordList{
    NSString *sql=@"select * from myFriends order by kid desc";
    FMResultSet *resultSet=[_database executeQuery:sql];
    NSMutableArray *marr=[[NSMutableArray alloc]init];
    while ([resultSet next])
    {

    }
    
    return marr;
}

//检查某是否被记录
-(BOOL)isExistRecordWithKid:(NSString *)kid{
    NSString *sql=@"select * from myFriends where kid = ?";
    FMResultSet *resultSet = [_database executeQuery:sql,[NSString stringWithFormat:@"%@",kid]];
    int count=0;
    while ([resultSet next])
    {
        count++;
    }
    return count>0;
}

//删除一条记录
-(BOOL)removeSelectedHistoryWithKid:(NSString *)kid
{
    NSString *sql=@"delete from myFriends where kid = ?";
    BOOL b=[_database executeUpdate:sql,kid];
    if (!b)
    {
        MQQLog(@"删除失败");
    }else{
        MQQLog(@"删除成功");
        
    }
    return YES;
}
///获取某一条好友信息
- (NSDictionary *)recordFriendDetail:(NSString *)kid{
    NSMutableDictionary *groupDic =[NSMutableDictionary dictionary];
    
    if ([self isExistRecordWithKid:kid]) {
        NSString *sql=@"select * from myFriends where kid = ?";
        FMResultSet *resultSet = [_database executeQuery:sql,[NSString stringWithFormat:@"%@",kid]];
        while ([resultSet next])
        {
            [groupDic setValue:[resultSet stringForColumn:@"kid"] forKey:@"kid"] ;
            [groupDic setValue:[resultSet stringForColumn:@"nickname"] forKey:@"nickname"] ;
            [groupDic setValue:[resultSet stringForColumn:@"url"] forKey:@"url"] ;
            
        }
        return groupDic;
        
    }
    return nil;

}

@end
