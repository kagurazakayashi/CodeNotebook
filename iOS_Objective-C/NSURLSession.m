// NSURLSession学习笔记（一）简介
+ (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(id <NSURLSessionDelegate>)delegate delegateQueue:(NSOperationQueue *)queue;  
// 第一种方式是使用静态的sharedSession方法，该类使用共享的会话，该会话使用全局的Cache，Cookie和证书。
// 第二种方式是通过sessionWithConfiguration:方法创建对象，也就是创建对应配置的会话，与NSURLSessionConfiguration合作使用。
// 第三种方式是通过sessionWithConfiguration:delegate:delegateQueue方法创建对象，二三两种方式可以创建一个新会话并定制其会话类型。该方式中指定了session的委托和委托所处的队列。当不再需要连接时，可以调用Session的invalidateAndCancel直接关闭，或者调用finishTasksAndInvalidate等待当前Task结束后关闭。这时Delegate会收到URLSession:didBecomeInvalidWithError:这个事件。Delegate收到这个事件之后会被解引用。

// 3.NSURLSessionTask类
// NSURLSessionTask是一个抽象子类，它有三个子类：NSURLSessionDataTask，NSURLSessionUploadTask和NSURLSessionDownloadTask。这三个类封装了现代应用程序的三个基本网络任务：获取数据，比如JSON或XML，以及上传和下载文件。
// 下面是其继承关系：

// 有多种方法创建对应的任务对象：
// （1）NSURLSessionDataTask
// 通过request对象或url创建：


/* Creates a data task with the given request.  The request may have a body stream. */  
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request;  
  
/* Creates a data task to retrieve the contents of the given URL. */  
- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url;  
通过request对象或url创建，同时指定任务完成后通过completionHandler指定回调的代码块：


/* 
 * data task convenience methods.  These methods create tasks that 
 * bypass the normal delegate calls for response and data delivery, 
 * and provide a simple cancelable asynchronous interface to receiving 
 * data.  Errors will be returned in the NSURLErrorDomain,  
 * see <Foundation/NSURLError.h>.  The delegate, if any, will still be 
 * called for authentication challenges. 
 */  
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;  
- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;  
（2）NSURLSessionUploadTask
// 通过request创建，在上传时指定文件源或数据源。



/* Creates an upload task with the given request.  The body of the request will be created from the file referenced by fileURL */  
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL;  
  
/* Creates an upload task with the given request.  The body of the request is provided from the bodyData. */  
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData;  
  
/* Creates an upload task with the given request.  The previously set body stream of the request (if any) is ignored and the URLSession:task:needNewBodyStream: delegate will be called when the body payload is required. */  
- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request;  
// 在创建upload task对象时，通过completionHandler指定任务完成后的回调代码块：


/* 
 * upload convenience method. 
 */  
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;  
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;  

// （3）NSURLSessionDownloadTask


/* Creates a download task with the given request. */  
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request;  
  
/* Creates a download task to download the contents of the given URL. */  
- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url;  
  
/* Creates a download task with the resume data.  If the download cannot be successfully resumed, URLSession:task:didCompleteWithError: will be called. */  
- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData;  
// 下载任务支持断点续传，第三种方式是通过之前已经下载的数据来创建下载任务。
// 同样地可以通过completionHandler指定任务完成后的回调代码块：


/* 
 * download task convenience methods.  When a download successfully 
 * completes, the NSURL will point to a file that must be read or 
 * copied during the invocation of the completion routine.  The file 
 * will be removed automatically. 
 */  
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;  
- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;  
- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;  

// 4.NSURLSessionDelegate和NSURLSessionTaskDelegate协议
// 在协议的方法中可以完成各种各样的回调动作，如身份验证、完成任务后的动作、错误处理和后台任务完成的动作等。委托方法指定在NSURLSession中一定数量的字节传输使用int64_t类型的参数。
// 这里只说下后台任务的一个委托方法：


/* If an application has received an 
 * -application:handleEventsForBackgroundURLSession:completionHandler: 
 * message, the session delegate will receive this message to indicate 
 * that all messages previously enqueued for this session have been 
 * delivered.  At this time it is safe to invoke the previously stored 
 * completion handler, or to begin any internal updates that will 
 * result in invoking the completion handler. 
 */  
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session NS_AVAILABLE_IOS(7_0);  
合作使用的ApplicationDelegate方法：
[objc] 
view plain
copy


// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the  
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing  
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving  
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving  
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.  
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler NS_AVAILABLE_IOS(7_0);  
// 将任务切换到后台之后，Session的Delegate不会再收到和Task相关的消息。当所有Task全都完成后，程序将被唤醒，并调用ApplicationDelegate的application:handleEventsForBackgroundURLSession:completionHandler:回调，在这里要为后台session（由background session的identifier标识）指定对应的回调代码块。
// 随后，对于每一个完成的后台Task调用该Session的Delegate中的URLSession:downloadTask:didFinishDownloadingToURL:（成功的话）和URLSession:task:didCompleteWithError:（成功或者失败都会调用）方法做处理，以上的回调代码块可以在这里调用。

// NSURLSession学习笔记（二）Session Task
// Session Task分为三种Data Task，Upload Task，Download Task。毫无疑问，Session Task是整个NSURLSession架构的核心目标。
// 下面写了一个简单的Demo来初步使用下三种任务对象。这里使用的是convenience methods，并没有定制session和使用协议，都是采用completionHandler作为回调动作。

// 故事板内容为：


// 第一种Data Task用于加载数据，使用全局的shared session和dataTaskWithRequest:completionHandler:方法创建。代码如下：


/* 使用NSURLSessionDataTask加载网页数据 */  
- (IBAction)loadData:(id)sender {  
    // 开始加载数据，让spinner转起来  
    [self.spinner startAnimating];  
      
    // 创建Data Task，用于打开我的csdn blog主页  
    NSURL *url = [NSURL URLWithString:@"http://blog.csdn.net/u010962810"];  
    NSURLRequest *request = [NSURLRequest requestWithURL:url];  
    NSURLSession *session = [NSURLSession sharedSession];  
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request  
                                                completionHandler:  
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {  
                                          // 输出返回的状态码，请求成功的话为200  
                                          [self showResponseCode:response];  
                                            
                                          // 在webView中加载数据  
                                          [self.webView loadData:data  
                                                        MIMEType:@"text/html"  
                                                textEncodingName:@"utf-8"  
                                                         baseURL:nil];  
                                            
                                          // 加载数据完毕，停止spinner  
                                          [self.spinner stopAnimating];  
                                      }];  
    // 使用resume方法启动任务  
    [dataTask resume];  
}  
  
/* 输出http响应的状态码 */  
- (void)showResponseCode:(NSURLResponse *)response {  
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;  
    NSInteger responseStatusCode = [httpResponse statusCode];  
    NSLog(@"%d", responseStatusCode);  
}  
// completionHandler指定任务完成后的动作。注意一定要使用resume方法启动任务。（Upload Task和Download Task同理）
// 运行结果：


// 第二种Upload Task用于完成上传文件任务，使用方法类似：


/* 使用NSURLSessionUploadTask上传文件 */  
- (IBAction)uploadFile:(id)sender {  
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];  
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];  
    NSData *data = ...;  
      
    NSURLSession *session = [NSURLSession sharedSession];  
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request  
                                                               fromData:data  
                                                      completionHandler:  
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {  
                                              // ...  
                                          }];  
      
    [uploadTask resume];  
}  

// 第三种Download Task用于完成下载文件的任务，使用全局的shared session和downloadTaskWithRequest:completionHandler:方法创建。
// 注意：在下载任务完成后，下载的文件位于tmp目录下，由代码块中的location指定（不妨输出看看），我们必须要在completion handler中将文件放到持久化的目录下保存。代码如下：


/* 使用NSURLSessionDownloadTask下载文件 */  
- (IBAction)downloadFile:(id)sender {  
    [self.spinner startAnimating];  
      
    NSURL *URL = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=6be5fc5f718da9774e2f812b8469f919/8b13632762d0f703b0faaab00afa513d2697c515.jpg"];  
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];  
    NSURLSession *session = [NSURLSession sharedSession];  
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request  
                                                            completionHandler:  
                                              ^(NSURL *location, NSURLResponse *response, NSError *error) {  
                                                  [self showResponseCode:response];  
                                                    
                                                  // 输出下载文件原来的存放目录  
                                                  NSLog(@"%@", location);  
                                                    
                                                  // 设置文件的存放目标路径  
                                                  NSString *documentsPath = [self getDocumentsPath];  
                                                  NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];  
                                                  NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];  
                                                    
                                                  // 如果该路径下文件已经存在，就要先将其移除，在移动文件  
                                                  NSFileManager *fileManager = [NSFileManager defaultManager];  
                                                  if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {  
                                                      [fileManager removeItemAtURL:fileURL error:NULL];  
                                                  }  
                                                  [fileManager moveItemAtURL:location toURL:fileURL error:NULL];  
                                                    
                                                  // 在webView中加载图片文件  
                                                  NSURLRequest *showImage_request = [NSURLRequest requestWithURL:fileURL];  
                                                  [self.webView loadRequest:showImage_request];  
                                                    
                                                  [self.spinner stopAnimating];  
                                              }];  
      
    [downloadTask resume];  
}  
  
/* 获取Documents文件夹的路径 */  
- (NSString *)getDocumentsPath {  
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsPath = documents[0];  
    return documentsPath;  
}  
// 运行结果：



// 这个Demo中没有为NSURLSession指定session的delegate，所以没有使用委托中的方法，功能比较有限，而且也没有自行定制session的配置，所以只能执行简单的任务，但是对于加载数据，下载一张图片等任务已经可以应付自如。对于创建后台下载任务，支持断点续传的下载任务等将在下一篇文章中分析介绍。

// NSURLSession学习笔记（三）Download Task
// NSURLSession的Download Task用于完成下载任务，本文介绍如何创建断点续传的下载任务和后台下载任务。

// 我们直接从分析Demo入手：
// 故事板如下：


// 只有一个View Controller，用于创建各种下载任务，并将下载后的图片显示到视图上，下载过程中会更新下载进度。
// 头文件代码如下：


#import <UIKit/UIKit.h>  
  
@interface ViewController : UIViewController <NSURLSessionDownloadDelegate>  
  
/* NSURLSessions */  
@property (strong, nonatomic)           NSURLSession *currentSession;    // 当前会话  
@property (strong, nonatomic, readonly) NSURLSession *backgroundSession; // 后台会话  
  
/* 下载任务 */  
@property (strong, nonatomic) NSURLSessionDownloadTask *cancellableTask; // 可取消的下载任务  
@property (strong, nonatomic) NSURLSessionDownloadTask *resumableTask;   // 可恢复的下载任务  
@property (strong, nonatomic) NSURLSessionDownloadTask *backgroundTask;  // 后台的下载任务  
  
/* 用于可恢复的下载任务的数据 */  
@property (strong, nonatomic) NSData *partialData;  
  
/* 显示已经下载的图片 */  
@property (weak, nonatomic) IBOutlet UIImageView *downloadedImageView;  
  
/* 下载进度 */  
@property (weak, nonatomic) IBOutlet UILabel *currentProgress_label;  
@property (weak, nonatomic) IBOutlet UIProgressView *downloadingProgressView;  
  
/* 工具栏上的按钮 */  
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancellableDownload_barButtonItem;  
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resumableDownload_barButtonItem;  
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backgroundDownload_barButtonItem;  
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelTask_barButtonItem;  
  
- (IBAction)cancellableDownload:(id)sender; // 创建可取消的下载任务  
- (IBAction)resumableDownload:(id)sender;   // 创建可恢复的下载任务  
- (IBAction)backgroundDownload:(id)sender;  // 创建后台下载任务  
- (IBAction)cancelDownloadTask:(id)sender;  // 取消所有下载任务  
  
@end  

// 一、创建普通的下载任务
// 这种下载任务是可以取消的，代码如下：


- (IBAction)cancellableDownload:(id)sender {  
    if (!self.cancellableTask) {  
        if (!self.currentSession) {  
            [self createCurrentSession];  
        }  
          
        NSString *imageURLStr = @"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg";  
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];  
        self.cancellableTask = [self.currentSession downloadTaskWithRequest:request];  
          
        [self setDownloadButtonsWithEnabled:NO];  
        self.downloadedImageView.image = nil;  
          
        [self.cancellableTask resume];  
    }  
}  
// 如果当前的session为空，首先需要创建一个session（该session使用默认配置模式，其delegate为自己）：



/* 创建当前的session */  
- (void)createCurrentSession {  
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];  
    self.currentSession = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:nil];  
    self.currentSession.sessionDescription = kCurrentSession;  
}  
// 随后创建下载任务并启动。
// 这种任务是可取消的，即下次下载又从0.0%开始：


if (self.cancellableTask) {  
    [self.cancellableTask cancel];  
    self.cancellableTask = nil;  
}  

// 二、创建可恢复的下载任务
// 可恢复的下载任务支持断点续传，也就是如果暂停当前任务，在下次再执行任务时，将从之前的下载进度中继续进行。因此我们首先需要一个NSData对象来保存已经下载的数据：


/* 用于可恢复的下载任务的数据 */  
@property (strong, nonatomic) NSData *partialData;  
// 执行下载任务时，如果是恢复下载，那么就使用downloadTaskWithResumeData:方法根据partialData继续下载。代码如下：


- (IBAction)resumableDownload:(id)sender {  
    if (!self.resumableTask) {  
        if (!self.currentSession) {  
            [self createCurrentSession];  
        }  
          
        if (self.partialData) { // 如果是之前被暂停的任务，就从已经保存的数据恢复下载  
            self.resumableTask = [self.currentSession downloadTaskWithResumeData:self.partialData];  
        }  
        else { // 否则创建下载任务  
            NSString *imageURLStr = @"http://farm3.staticflickr.com/2846/9823925914_78cd653ac9_b_d.jpg";  
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];  
            self.resumableTask = [self.currentSession downloadTaskWithRequest:request];  
        }  
          
        [self setDownloadButtonsWithEnabled:NO];  
        self.downloadedImageView.image = nil;  
          
        [self.resumableTask resume];  
    }  
}  
// 在取消下载任务时，要将partialData数据保存起来，而且不要调用cancel方法：


else if (self.resumableTask) {  
    [self.resumableTask cancelByProducingResumeData:^(NSData *resumeData) {  
        // 如果是可恢复的下载任务，应该先将数据保存到partialData中，注意在这里不要调用cancel方法  
        self.partialData = resumeData;  
        self.resumableTask = nil;  
    }];  
}  
// 另外在恢复下载时，NSURLSessionDownloadDelegate中的以下方法将被调用：


/* 从fileOffset位移处恢复下载任务 */  
- (void)URLSession:(NSURLSession *)session  
      downloadTask:(NSURLSessionDownloadTask *)downloadTask  
 didResumeAtOffset:(int64_t)fileOffset  
expectedTotalBytes:(int64_t)expectedTotalBytes {  
    NSLog(@"NSURLSessionDownloadDelegate: Resume download at %lld", fileOffset);  
}  

// 三、创建后台下载任务
// 后台下载任务，顾名思义，当程序进入后台后，下载任务依然继续执行。
// 首先创建一个后台session单例，这里的Session配置使用后台配置模式，使用backgroundSessinConfiguration:方法配置时应该通过后面的参数为该后台进程指定一个标识符，在有多个后台下载任务时这个标识符就起作用了。


/* 创建一个后台session单例 */  
- (NSURLSession *)backgroundSession {  
    static NSURLSession *backgroundSess = nil;  
    static dispatch_once_t onceToken;  
    dispatch_once(&onceToken, ^{  
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfiguration:kBackgroundSessionID];  
        backgroundSess = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];  
        backgroundSess.sessionDescription = kBackgroundSession;  
    });  
      
    return backgroundSess;  
}  
// 在创建后台下载任务时，应该使用后台session创建，然后resume。


- (IBAction)backgroundDownload:(id)sender {  
    NSString *imageURLStr = @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg";  
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];  
    self.backgroundTask = [self.backgroundSession downloadTaskWithRequest:request];  
      
    [self setDownloadButtonsWithEnabled:NO];  
    self.downloadedImageView.image = nil;  
      
    [self.backgroundTask resume];  
}  
// 在程序进入后台后，如果下载任务完成，程序委托中的对应方法将被回调：


/* 后台下载任务完成后，程序被唤醒，该方法将被调用 */  
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {  
    NSLog(@"Application Delegate: Background download task finished");  
      
    // 设置回调的完成代码块  
    self.backgroundURLSessionCompletionHandler = completionHandler;  
}  
// 然后调用NSURLSessionDownloadDelegate中的方法：
// 以下是
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL*)location;
// 中的方法，该方法只有下载成功才被调用：


else if (session == self.backgroundSession) {  
    self.backgroundTask = nil;  
    AppDelegate *appDelegate = [AppDelegate sharedDelegate];  
    if (appDelegate.backgroundURLSessionCompletionHandler) {  
        // 执行回调代码块  
        void (^handler)() = appDelegate.backgroundURLSessionCompletionHandler;  
        appDelegate.backgroundURLSessionCompletionHandler = nil;  
        handler();  
    }  
}  
// 另外无论下载成功与否，以下方法都会被调用：


/* 完成下载任务，无论下载成功还是失败都调用该方法 */  
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {  
    NSLog(@"NSURLSessionDownloadDelegate: Complete task");  
      
    dispatch_async(dispatch_get_main_queue(), ^{  
        [self setDownloadButtonsWithEnabled:YES];  
    });  
      
    if (error) {  
        NSLog(@"下载失败：%@", error);  
        [self setDownloadProgress:0.0];  
        self.downloadedImageView.image = nil;  
    }  
}  
// 取消后台下载任务时直接cancel即可：


else if (self.backgroundTask) {  
    [self.backgroundTask cancel];  
    self.backgroundTask = nil;  
}  

// 四、NSURLSessionDownloadDelegate
// 为了实现下载进度的显示，需要在委托中的以下方法中实现：


/* 执行下载任务时有数据写入 */  
- (void)URLSession:(NSURLSession *)session  
      downloadTask:(NSURLSessionDownloadTask *)downloadTask  
      didWriteData:(int64_t)bytesWritten // 每次写入的data字节数  
 totalBytesWritten:(int64_t)totalBytesWritten // 当前一共写入的data字节数  
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite // 期望收到的所有data字节数  
{  
    // 计算当前下载进度并更新视图  
    double downloadProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;  
    [self setDownloadProgress:downloadProgress];  
}  
  
/* 根据下载进度更新视图 */  
- (void)setDownloadProgress:(double)progress {  
    NSString *progressStr = [NSString stringWithFormat:@"%.1f", progress * 100];  
    progressStr = [progressStr stringByAppendingString:@"%"];  
      
    dispatch_async(dispatch_get_main_queue(), ^{  
        self.downloadingProgressView.progress = progress;  
        self.currentProgress_label.text = progressStr;  
    });  
}  

// 从已经保存的数据中恢复下载任务的委托方法，fileOffset指定了恢复下载时的文件位移字节数：


/* Sent when a download has been resumed. If a download failed with an 
 * error, the -userInfo dictionary of the error will contain an 
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume 
 * data.  
 */  
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask  
                                      didResumeAtOffset:(int64_t)fileOffset  
                                     expectedTotalBytes:(int64_t)expectedTotalBytes;  

// 只有下载成功才调用的委托方法，在该方法中应该将下载成功后的文件移动到我们想要的目标路径：



/* Sent when a download task that has completed a download.  The delegate should  
 * copy or move the file at the given location to a new location as it will be  
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will 
 * still be called. 
 */  
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask  
                              didFinishDownloadingToURL:(NSURL *)location;  

// 无论下载成功或失败都会调用的方法，类似于try-catch-finally中的finally语句块的执行。如果下载成功，那么error参数的值为nil，否则下载失败，可以通过该参数查看出错信息：



/* Sent as the last message related to a specific task.  Error may be 
 * nil, which implies that no error occurred and this task is complete.  
 */  
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task  
                           didCompleteWithError:(NSError *)error;  


// 后台下载的运行结果：
// 启动任务后，进入后台：


// 下载完成后，控制台将会“通知”我们：

/*
2014-02-05 18:30:39.767 DownloadTask[3472:70b] Application Delegate: App did become active  
2014-02-05 18:30:43.734 DownloadTask[3472:70b] Application Delegate: App will resign active  
2014-02-05 18:30:43.735 DownloadTask[3472:70b] Application Delegate: App did enter background  
2014-02-05 18:30:45.282 DownloadTask[3472:70b] Application Delegate: Background download task finished  
2014-02-05 18:30:45.285 DownloadTask[3472:4907] NSURLSessionDownloadDelegate: Finish downloading  
2014-02-05 18:30:45.301 DownloadTask[3472:4907] NSURLSessionDownloadDelegate: Complete task  
再次启动程序，可以看到加载好的页面：


可以看到，通过后台下载让我们的程序更加异步地运行。NSURLSession封装了对应的接口，让我们要执行的任务更加专门化，这个新的网络架构的功能真的很强大。

*/