//
//  FMTMainViewController.h
//  FMTDownloadImg
//
//  Created by 凡施健 on 13-6-9.
//  Copyright (c) 2013年 凡施健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTDownloadManager.h"

@interface FMTMainViewController : UIViewController <FMTDownloadManagerDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *imgTable;
    
    NSMutableArray *imgArray;
}

@end
