//
//  ViewController.m
//  SwiftOCTest
//
//  Created by huweitao on 2018/9/5.
//  Copyright © 2018年 huweitao. All rights reserved.
//

#import "ViewController.h"
#import "SwiftOCTest-Swift.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextView *linkTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    NSLog(@"Local transToTime: %@, current: %@",[[self class] transformToStringWithTimestamp:@"1540542433"],[NSDate date]);
}


/**
 *  将0时区的时间戳转成8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithTimestamp:(NSString *)timestamp{
    //1.先将时间戳->NSDate
    NSDate *date = [self transformToDateWithTimestamp:timestamp];
    //2.将date->NSString
    return [[self transformToStringWithDate:date] substringToIndex:16];
}

/**
 *  将0时区的时间戳转成0时区的时间
 */
+ (NSDate *)transformToDateWithTimestamp:(NSString *)timestamp{
    NSTimeInterval inter = [timestamp doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:inter];
    return date;
}

/**
 *  将0时区的NSDate转成 8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithDate:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"dd MMM yyyy|hh:mm a"];
    NSString *string = [df stringFromDate:date];
    return string;
}

- (void)printTimeZone {
    NSDate *date = [NSDate date];
    NSLog(@"当前时间%@",date);
    
    //2.打印出2011-11-12 23：10：34这种格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSLog(@"字符串表示1:%@",dateStr);
    
    //3.打印出2013年12月22日 12时34分56秒这个格式
    NSDateFormatter *dateFormaterA = [[NSDateFormatter alloc]init];
    [dateFormaterA setDateFormat:@"yyyy年MM年dd日 HH时mm分ss秒"];
    NSString *dateStrA = [dateFormaterA stringFromDate:date];
    NSLog(@"%@",dateStrA);
}

- (IBAction)clickButton:(id)sender {
    NSString *customURL = @"gcash://gcash.splashscreen/?redirect=gcash%3a%2f%2fcom.mynt.gcash%2fapp%2f006300000200%3fcaptureWebView%3dtrue%26removeDuplicatedPage%3dtrue%26url%3dhttps%253A%252F%252Fm-gcash-com.s3.ap-southeast-1.amazonaws.com%252Fgcashapp%252Fgcash-christmas-campaign-web%252Findex.html%2523%252F";
    if (self.linkTextField.text.length > 0) {
        customURL = self.linkTextField.text;
    }
    // gcash://gcash.splashscreen/?redirect=gcash%3A%2F%2Fcom.mynt.gcash%2Fapp%2F006300000700
    // valid gcash://gcash.splashscreen/?redirect=gcash%3A%2F%2Fcom.mynt.gcash%2Fapp%2F006300000200%3Furl%3Dhttps%253A%252F%252Fs3.ap-southeast-1.amazonaws.com%252Fuat.m.gcash.com%252Fgcashapp%252Fgcash-gift-money-web%252Findex.html%2523%252Freceiving%253FbizNo%253D2018102710121413010100170253800001013
    // gcash://gcash.splashscreen/?redirect=gcash://com.mynt.gcash/app/006300000200?url=https://s3.ap-southeast-1.amazonaws.com/uat.m.gcash.com/gcashapp/gcash-gift-money-web/index.html#/receiving?bizNo=2018102710121413010100170253800001013
    // gcash://gcash.splashscreen/?redirect=gcash://com.mynt.gcash/app/6300000300?url=https://s3.ap-southeast-1.amazonaws.com/uat.m.gcash.com/gcashapp/gcash-gift-money-web/index.html#/receiving?bizNo=2018102710121413010100170253800001013
    // gcash://com.mynt.gcash/app/006300000200?url=https://www.baidu.com/
//    NSString *outerLink = @"http://s3.ap-southeast-1.amazonaws.com/uat.m.gcash.com/gcashapp/gcash-gift-money-web/index.html#/landing?bizNo=8802700";
//    customURL = outerLink;
    // gcash://gcash.splashscreen/?redirect=gcahs%3a%2f%2fcom.mynt.gcash%2fapp%2f006300000200?shortUrl=http%3a%2f%2faphome.ph.core.alipay.net%2fa%2fqs4xtx
    if ([[UIApplication sharedApplication]
         canOpenURL:[NSURL URLWithString:customURL]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL error"
                                                        message:[NSString stringWithFormat:
                                                                 @"No custom URL defined for %@", customURL]
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
