//
//  FMTMainViewController.m
//  FMTDownloadImg
//
//  Created by 凡施健 on 13-6-9.
//  Copyright (c) 2013年 凡施健. All rights reserved.
//

#import "FMTMainViewController.h"
#import "FMTImgCell.h"

@interface FMTMainViewController ()

@end

@implementation FMTMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imgArray = [[NSMutableArray alloc] init];
    
    NSString *url_1 = @"http://10.28.1.69/img/product/pro1.jpg";
    NSString *url_2 = @"http://10.28.1.69/img/product/pro2.jpg";
    NSString *url_3 = @"http://10.28.1.69/img/product/pro3.jpg";
    NSString *url_4 = @"http://10.28.1.69/img/product/pro4.jpg";
    NSString *url_5 = @"http://10.28.1.69/img/product/pro5.jpg";
    NSArray *array = [[NSArray alloc] initWithObjects:url_1,url_2,url_3,url_4,url_5, nil];
    for (NSString *aUrl in array) {
        FMTDownloadManager *downloadManager = [[FMTDownloadManager alloc] init];
        downloadManager.url = aUrl;
        downloadManager.delegate = self;
        [downloadManager download];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fileDownloaderDidFinishDownload:(id)sender {
    FMTDownloadManager *manager = (FMTDownloadManager *)sender;
    NSLog(@"path == :%@",manager.fileName);
    UIImage *aImage = [[UIImage alloc] initWithContentsOfFile:manager.fileName];
    [imgArray addObject:aImage];
    [imgTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [imgArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ImgCell = @"ImgCell";
    FMTImgCell *cell = (FMTImgCell *)[tableView dequeueReusableCellWithIdentifier:ImgCell];
    if (cell == nil) {
        NSArray *libs = [[NSBundle mainBundle] loadNibNamed:@"FMTImgCell" owner:self options:nil];
        for (NSObject *object in libs) {
            if ([object isKindOfClass:[FMTImgCell class]]) {
                cell = (FMTImgCell *)object;
            }
        }
    }
    NSInteger row = [indexPath row];
    [cell.imageView setImage:[imgArray objectAtIndex:row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101;
}
@end
