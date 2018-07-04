//
//  InvitationManager.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 2/10/15.
//  Copyright (c) 2015 dujiepeng. All rights reserved.
//  用来处理UIDemo上的数据，您使用时请自己处理相关部分db



#import <Foundation/Foundation.h>

@class ApplyEntity;
@interface InvitationManager : NSObject

+ (instancetype)sharedInstance;

-(void)addInvitation:(ApplyEntity *)applyEntity loginUser:(NSString *)username;

-(void)removeInvitation:(ApplyEntity *)applyEntity loginUser:(NSString *)username;

- (NSArray *)applyEmtitiesWithloginUser:(NSString *)username;

@end

@interface ApplyEntity : NSObject 

@property (nonatomic, strong) NSString * applicantUsername;
@property (nonatomic, strong) NSString * applicantNick;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, strong) NSString * receiverUsername;
@property (nonatomic, strong) NSString * receiverNick;
@property (nonatomic, strong) NSNumber * style;
@property (nonatomic, strong) NSString * groupId;
@property (nonatomic, strong) NSString * groupSubject;

@end
