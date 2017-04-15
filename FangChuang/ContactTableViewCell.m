//
//  ContactTableViewCell.m
//  FangChuang
//
//  Created by omni on 14-4-9.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

//第三部分，联系人的cell
#import "ContactTableViewCell.h"

@implementation ContactTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //cell背景图
//        UIImage* bcImg = [UIImage imageNamed:@"60_kuang_1"];
//        UIImageView* bcImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
//        [bcImgV setImage:bcImg];
//        [self.contentView addSubview:bcImgV];
        
//        //箭头
//        UIImageView *jiantouImage=[[UIImageView alloc]initWithFrame:CGRectMake(320-10-23/2, (70-20.5)/2, 23/2, 41/2)];
//        [jiantouImage setImage:[UIImage imageNamed:@"45_jiantou_1"]];
//        [self.contentView addSubview:jiantouImage];
        
       
        //图像
        /*
      UIImage *image=[UIImage imageNamed:@"61_touxiang_1"];
        
            //    UIImageView *headerImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//               [headerImage setImage:image];
//                [cell.contentView addSubview:headerImage];
//                [headerImage release];
        
       _headView = [[CacheImageView alloc]initWithImage:image Frame:CGRectMake(10, 10, 50, 50)];
       [_headView setBackgroundColor:[UIColor clearColor]];
       [self.contentView addSubview:_headView];
      */
        
        //2014.06.12 chenlihua 修改图片缓存的方式
        _headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [_headView setBackgroundColor:[UIColor clearColor]];
       [self.contentView addSubview:_headView];
        
        
        //        UIButton *headBut=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        //        [headBut setBackgroundColor:[UIColor clearColor]];
        //        [headBut setTag:1111+indexPath.row];
        //        [headBut addTarget:self action:@selector(JianJieEvent:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.contentView addSubview:headBut];
        //        [headBut release];
        
        //姓名字的Label
        UILabel *xingminglab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headView.frame)+10, 25, 40, 20)];
        [xingminglab setBackgroundColor:[UIColor clearColor]];
        [xingminglab setText:@"姓名:"];
        [xingminglab setFont: [UIFont systemFontOfSize:14]];
        [xingminglab setTextColor:[UIColor grayColor]];
        [xingminglab setFont:[UIFont fontWithName:KUIFont size:14]];
        [self.contentView addSubview:xingminglab];
        
        //姓名内容的Label
        _xingmlab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(xingminglab.frame)+5, 25, 120, 20)];
        [_xingmlab setBackgroundColor:[UIColor clearColor]];
        [_xingmlab setFont:[UIFont systemFontOfSize:14]];
        [_xingmlab setTextColor:[UIColor grayColor]];
        [_xingmlab setFont:[UIFont fontWithName:KUIFont size:14]];
        [self.contentView addSubview:_xingmlab];
        
        //cell下边的线，cell本身的颜色要浅
        //2014.08.14 chenlihua 将线由1改成0.5.
        UIImageView *xianNextIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0,70-1, 320, 0.5)];
        [xianNextIMG setImage:[UIImage imageNamed:@"004_fengexian_1"]];
        [self.contentView addSubview:xianNextIMG];
    }
    return self;
}

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
