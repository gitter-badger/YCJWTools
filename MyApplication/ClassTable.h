//
//  ClassTable.h
//  MyApplication
//
//  Created by DwightDing on 16/6/10.
//  Copyright © 2016年 Ding Chenguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassTable : NSObject
@property (atomic,assign) int classNo;
@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, copy) NSString *coursePeriod;
@property (nonatomic, copy) NSString *classRoom;
@property (nonatomic, copy) NSString *teacher;
@property (atomic,assign) int classLong;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)demoWithDict:(NSDictionary *)dict;

@end
