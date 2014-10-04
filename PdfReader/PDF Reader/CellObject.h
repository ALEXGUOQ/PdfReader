//
//  CellObject.h
//  MyPdfReader
//
//  Created by chang on 14-9-6.
//  Copyright (c) 2014年 chang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellObject : NSObject

@property(nonatomic,strong)NSString * index;// pdf页码
@property(nonatomic,strong)NSString *title;// pdf title
@property(nonatomic,strong)NSArray *subContents;// 子内容
@property(nonatomic,strong)NSString *superIndex;// 父目录indexPath.row
@property(nonatomic)BOOL isUnfold;// 是否展开
@property(nonatomic,strong)NSString *cellLavel;// 标记是第几层

@end
