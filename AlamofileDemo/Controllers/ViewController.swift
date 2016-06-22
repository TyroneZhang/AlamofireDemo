//
//  ViewController.swift
//  AlamofileDemo
//
//  Created by Zhangyao on 14/2/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    var downloadPath = "http://192.168.2.195:8088/ebooks/3D%E6%89%93%E5%8D%B0%EF%BC%9A%E4%BB%8E%E6%83%B3%E8%B1%A1%E5%88%B0%E7%8E%B0%E5%AE%9E%E2%80%94%E2%80%94%209787508638584.epub"
    //用于停止下载时，保存已下载的部分
    var cancelledData: NSData?
    var downloadRequest: Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.opacity = 0.6
        hud.labelText = "Loading"
        hud.removeFromSuperViewOnHide = true
        AFDataAccessRequest.fetchLibraries(success: { result in
                if let baseModel:BaseModel = result as? BaseModel {
                    print(baseModel)
                }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            })
            { failureResult in
                print(failureResult)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        print("do other task")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getDownloadDestination() -> NSURL {
        
        let fileManager = NSFileManager()
        let directory = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0]
        let foleder = directory.URLByAppendingPathComponent("downloadBooks", isDirectory: true)
        if !fileManager.fileExistsAtPath(foleder.path!) {
            try! fileManager.createDirectoryAtURL(foleder, withIntermediateDirectories: true, attributes: nil)
        }
        return foleder.URLByAppendingPathComponent("xx.epub", isDirectory: false)
    }
    
    @IBAction func startDownload(sender: AnyObject) {
        
        weak var weakSelf = self
        self.downloadRequest = Alamofire.download(.GET, downloadPath) { temporaryURL, response in
            return weakSelf!.getDownloadDestination()
        }
        self.downloadRequest!.progress(downloadProgress) //下载进度
        self.downloadRequest!.response(completionHandler: downloadResponse) //下载停止响应
        
        
        
//        Alamofire.download(.GET, downloadPath, destination: self.test())
//            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
//                print(totalBytesRead)
//                
//                // This closure is NOT called on the main queue for performance
//                // reasons. To update your ui, dispatch to the main queue.
//                dispatch_async(dispatch_get_main_queue()) {
//                    print("Total bytes read on main queue: \(totalBytesRead)")
//                }
//            }
//            .response { _, _, _, error in
//                if let error = error {
//                    print("Failed with error: \(error)")
//                } else {
//                    print("Downloaded file successfully")
//                }
//        }
        
        
        
    }
    
    @IBAction func stopDownload(sender: AnyObject) {
        self.downloadRequest!.cancel()
    }
    
    //下载过程中改变进度条
    private func downloadProgress(bytesRead: Int64, totalBytesRead: Int64,
                          totalBytesExpectedToRead: Int64) {
        let percent = Float(totalBytesRead)/Float(totalBytesExpectedToRead)
        //进度条更新
        dispatch_async(dispatch_get_main_queue(), {
            self.progressView.setProgress(percent,animated:true)
        })
        print("当前进度：\(percent*100)%")
    }
    
    //下载停止响应（不管成功或者失败）
    private func downloadResponse(request: NSURLRequest?, response: NSHTTPURLResponse?,
                          data: NSData?, error:NSError?) {
        if let error = error {
            if error.code == NSURLErrorCancelled {
                self.cancelledData = data //意外终止的话，把已下载的数据储存起来
            } else {
                print("Failed to download file: \(response) \(error)")
            }
        } else {
            print("Successfully downloaded file: \(response)")
//            let manager = NSFileManager.defaultManager()
//            do {
//                try manager.removeItemAtURL(self.getDownloadDestination())
//            } catch {
//                fatalError()
//            }
        }
    }
    
    
    func test() -> (NSURL, NSHTTPURLResponse) -> NSURL
    {
        weak var weakSelf = self
        return { temporaryURL, response -> NSURL in
            return weakSelf!.getDownloadDestination()
        }
    }
    
    private func continueDownload() {
        if let cancelledData = self.cancelledData {
            //下载文件的保存路径
            self.downloadRequest = Alamofire.download(resumeData: cancelledData,
                                                      destination: self.test())
            self.downloadRequest!.progress(downloadProgress) //下载进度
            self.downloadRequest!.response(completionHandler: downloadResponse) //下载停止响应
        }
    }

}

