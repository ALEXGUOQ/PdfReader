//
//  ContentsTableViewCell.m
//  MyPdfReader
//
//  Created by chang on 14-9-2.
//  Copyright (c) 2014年 chang. All rights reserved.
//

#import "ContentsTableViewCell.h"

@implementation ContentsTableViewCell
@synthesize isUnfold;
//@synthesize subContentsArray;
@synthesize imageView;


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
