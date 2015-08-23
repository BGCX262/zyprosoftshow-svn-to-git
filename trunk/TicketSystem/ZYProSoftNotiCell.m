//
//  ZYProSoftNotiCell.m
//  TicketSystem
//
//  Created by ZYVincent on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "ZYProSoftNotiCell.h"

@implementation ZYProSoftNotiCell
@synthesize usersLabel;
@synthesize subjectLabel;
@synthesize cellBackgroundImgView;
@synthesize notiTypeImgView;

- (void)setWithNotiSubject:(NSString *)subject withNotiUser:(NSString *)users
{
    subjectLabel.text = subject;
    usersLabel.text = users;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [cellBackgroundImgView release];
    [subjectLabel release];
    [usersLabel release];
    [notiTypeImgView release];
    [super dealloc];
}
@end
