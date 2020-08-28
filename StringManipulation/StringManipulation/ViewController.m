//
//  ViewController.m
//  StringManipulation
//
//  Created by Estelle Paus on 8/28/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * current = @"http://inu.tapptic.com/test/image.php?text=%E4%B8%80";
    NSString * newString = [self fixUrl:current];
    NSLog(@"%@",newString);
}

-(NSString *)fixUrl:(NSString*) url  {
    NSString * newString = [url stringByReplacingOccurrencesOfString:@"http"
    withString:@"https"];
    return newString;
}


@end
