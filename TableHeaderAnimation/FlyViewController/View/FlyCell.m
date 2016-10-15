//
//  FlyCell.m
//  动画第二次分享
//
//  Created by Lishten on 15/8/27.
//  Copyright (c) 2015年 Lishten. All rights reserved.
//

#import "FlyCell.h"

@interface FlyCell()
@property (weak, nonatomic) IBOutlet UIView *leftBackView;

@end
@implementation FlyCell

- (void)awakeFromNib {
    // Initialization code
    self.leftBackView.layer.cornerRadius = 20;
    CGFloat r = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat g = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat b = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    self.leftBackView.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    
    
}

- (void)setAnimation
{
  
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//    anim.duration = 0.35;
//    anim.fromValue = @0;
//    anim.toValue = @(self.frame.size.width);
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.layer addAnimation:anim forKey:nil];
   
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    anim1.duration = 0.35;
    anim1.toValue = @(M_PI);
    [self.leftBackView.layer addAnimation:anim1 forKey:nil];
    
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    anim.duration = 0.35;
//    anim.toValue = @(M_PI);
//    [self.title.layer addAnimation:anim forKey:nil];
//    if (anim) {
//        [self.layer removeAllAnimations];
//    } else {
////        [self.layer addAnimation:anim forKey:nil];
//    }
//   [UIView animateWithDuration:1 animations:^{
//       [self.layer setValue:@0 forKeyPath:@"transform.translation.x"];
//       [self.layer setValue:@(self.frame.size.width) forKeyPath:@"transform.translation.x"];
//   }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
