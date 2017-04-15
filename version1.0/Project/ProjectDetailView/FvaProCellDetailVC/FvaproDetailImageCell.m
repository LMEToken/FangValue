//
//  FvaproDetailImageCell.m
//  FangChuang
//
//  Created by weiping on 14-9-19.
//  Copyright (c) 2014年 蓝色互动. All rights reserved.
//

#import "FvaproDetailImageCell.h"

@implementation FvaproDetailImageCell
@synthesize heradbt,heradlabe,heradbt2,heradbt2labe,heradbt3,heradbt3labe,heradbt4,heradbt4labe;
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [heradbt setBackgroundImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
 
    heradlabe.text = @"Tom";
    [heradlabe setFont:[UIFont fontWithName:KUIFont size:10]];
    [heradbt2 setBackgroundImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
   heradbt2labe.text = @"Tom";
    [heradbt2labe setFont:[UIFont fontWithName:KUIFont size:10]];
    [heradbt3 setBackgroundImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
   heradbt3labe.text = @"Tom";
    [heradbt3labe setFont:[UIFont fontWithName:KUIFont size:10]];
    [heradbt4 setBackgroundImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
    heradbt4labe.text = @"Tom";
    [heradbt4labe setFont:[UIFont fontWithName:KUIFont size:10]];
    UIImageView *myview = [[UIImageView alloc]initWithFrame:CGRectMake(200, 10, 15, 20)];
    [myview setImage:[UIImage imageNamed:@"accessory"]];
    imagearr = [[NSArray alloc]init];
     lableaarr = [[NSArray alloc]init];
    self.accessoryView = myview;
    heradbt.tag =1;
    heradbt2.tag = 2;
    heradbt3.tag = 3;
    heradbt4.tag = 4;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (IBAction)imagebt:(UIButton *)sender {
//    changeindex = changeindex +1;
//
//    imagearr = [NSArray arrayWithObjects:@"team",@"team",@"team",@"team",@"team",@"team",@"team", nil];
//
//      lableaarr = [NSArray arrayWithObjects:@"tom", @"tom1",@"tom2",@"tom3",@"tom4",@"tom5",@"tom6",nil];
//    if (changeindex<([lableaarr count]-4)) {
//       
//        [heradbt setBackgroundImage:[UIImage imageNamed:[imagearr objectAtIndex:changeindex]] forState:UIControlStateNormal];
//        heradlabe.text = [lableaarr objectAtIndex:changeindex];
//        
//        [heradbt2 setBackgroundImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
//        heradbt2labe.text = [lableaarr objectAtIndex:changeindex+1];
//        
//        [heradbt3 setBackgroundImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
//        heradbt3labe.text =  [lableaarr objectAtIndex:changeindex+2];
//        
//        [heradbt4 setBackgroundImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
//        heradbt4labe.text =  [lableaarr objectAtIndex:changeindex+3];
//    }
//
//}
@end
