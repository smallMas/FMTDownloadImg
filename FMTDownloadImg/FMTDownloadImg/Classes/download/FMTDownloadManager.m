//
//  FMTDownloadManager.m
//  FMTDownloadImg
//
//  Created by 凡施健 on 13-6-9.
//  Copyright (c) 2013年 凡施健. All rights reserved.
//

#import "FMTDownloadManager.h"

@implementation FMTDownloadManager

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)download {
    NSString *directory = NSTemporaryDirectory(); // 创建临时目录
    _fileName = [directory stringByAppendingPathComponent:[_url lastPathComponent]]; // 加/  再加url最后一个名字
    tmpFileName = [_fileName stringByAppendingPathExtension:@"tmp"]; // 加后缀 tmp(用于临时存储)
    
    NSFileManager *fileManaer = [NSFileManager defaultManager];
    if ([fileManaer fileExistsAtPath:_fileName]) {
        // 本地已经存在图片了
        if (self.delegate && [self.delegate respondsToSelector:@selector(fileDownloaderDidFinishDownload:)]) {
            [self.delegate fileDownloaderDidFinishDownload:self];
        }
    }else {
        // 本地不存在图片，需要下载图片
        [fileManaer createFileAtPath:tmpFileName contents:[NSData data] attributes:nil];// 创建目录
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:tmpFileName];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];// 请求url
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:_fileName error:nil];
	[fileManager moveItemAtPath:tmpFileName toPath:_fileName error:nil];
	
	if ([self.delegate respondsToSelector:@selector(fileDownloaderDidFinishDownload:)]) {
		[self.delegate fileDownloaderDidFinishDownload:self];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[fileHandle writeData:data];
}
@end
