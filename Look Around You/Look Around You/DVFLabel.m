//
//  DVFLabel.m
//  Look Around You
//
//  Created by Neil Kimmett on 14/10/2013.
//  Copyright (c) 2013 dev/forst. All rights reserved.
//

#import "DVFLabel.h"
#import "DVFStyle.h"

@implementation DVFLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.font = [DVFStyle fontWithSize:self.font.pointSize];
}

@end
