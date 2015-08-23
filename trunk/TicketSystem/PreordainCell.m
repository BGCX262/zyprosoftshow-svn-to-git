//
//  PreordainCell.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-19.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.
//  http://www.ruyijian.com
//    团队QQ群号：219357847
//    团队主题：奋斗路上携手相伴！

#import "PreordainCell.h"

@implementation PreordainCell
@synthesize PositionContentLabel;
@synthesize ticketIDLabel;
@synthesize ticketTypeLabel;
@synthesize ticketPriceLabel;
@synthesize ticketPositionLabel;
@synthesize IDContentLabel;
@synthesize TypeContentLabel;
@synthesize PriceContentLabel;
@synthesize LastCountLabel;
@synthesize PreordainButton;
@synthesize typeImage;
@synthesize ticketLastCountLabel;
@synthesize delegate;

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
//设置cell内容
- (void)setTicketInfo:(Ticket *)ticket
{
    self.IDContentLabel.text = ticket.ticketID;
    self.PositionContentLabel.text = ticket.ticketPosition;
    self.PriceContentLabel.text = ticket.ticketPrice;
    self.TypeContentLabel.text = ticket.ticketType;
    self.LastCountLabel.text = ticket.ticketCount;
}
- (void)dealloc {
    [typeImage release];
    [ticketIDLabel release];
    [ticketTypeLabel release];
    [ticketPriceLabel release];
    [ticketPositionLabel release];
    [IDContentLabel release];
    [TypeContentLabel release];
    [PriceContentLabel release];
    [PositionContentLabel release];
    [LastCountLabel release];
    [PreordainButton release];
    [ticketLastCountLabel release];
    [super dealloc];
}
- (IBAction)tapOnButton:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(tapOnPreordainButton:)]) {
        [delegate tapOnPreordainButton:sender];
    }
}
//设置成员信息
- (void)setZYProSofter:(ZYProSofter *)zyProSofter
{
    self.IDContentLabel.text = zyProSofter.memberID;
    self.PositionContentLabel.text = zyProSofter.memberName;
}
@end
