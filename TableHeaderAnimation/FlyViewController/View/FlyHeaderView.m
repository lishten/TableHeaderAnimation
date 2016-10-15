//
//  FlyHeaderView.m
//  动画第二次分享
//
//  Created by Lishten on 15/8/26.
//  Copyright (c) 2015年 Lishten. All rights reserved.
//

#import "FlyHeaderView.h"

@interface FlyHeaderView()

@end

@implementation FlyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
        
    }
    return self;
}


- (void)initWithUI
{
    self.bImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 160)];
    self.bImageView.backgroundColor = [UIColor yellowColor];
    self.flyBackView = [[UIView alloc]initWithFrame:CGRectMake(10,160 , 50, 50)];
    self.flyBackView.backgroundColor = [UIColor greenColor];
    self.flyBackView.layer.cornerRadius = 25;
    self.flyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 160, 40, 40)];
    self.flyImageView.image = [UIImage imageNamed:@"ic_send"];
    [self addSubview:self.bImageView];
    
    [self.bImageView addSubview:self.flyBackView];
    
    [self.bImageView addSubview:self.flyImageView];

}
@end
