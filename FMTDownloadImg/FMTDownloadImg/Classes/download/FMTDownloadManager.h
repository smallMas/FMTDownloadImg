//
//  FMTDownloadManager.h
//  FMTDownloadImg
//
//  Created by 凡施健 on 13-6-9.
//  Copyright (c) 2013年 凡施健. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FMTDownloadManagerDelegate <NSObject>

- (void)fileDownloaderDidFinishDownload:(id)sender;

@end

@interface FMTDownloadManager : NSObject {
    NSFileHandle *fileHandle;
    NSString *tmpFileName;
}
@property (nonatomic,strong)NSString *url;
@property (nonatomic,assign)id<FMTDownloadManagerDelegate> delegate;
@property (nonatomic,strong)NSString *fileName;

- (void)download;

@end
