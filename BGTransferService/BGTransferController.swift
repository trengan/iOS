//
//  BGTransferController.swift
//  BGTransferService
//
//  Created by Thiyagarajan Renganathan on 24/11/19.
//  Copyright © 2019 Thiyagarajan Renganathan. All rights reserved.
//

import Foundation
import UIKit

public class BGTransferController: NSObject{
    
    var completed:((URL)->Void)?
    var onProgress : ((Double)->Void)?
    
     private lazy var  urlSession : URLSession = {
        var config = URLSessionConfiguration.background(withIdentifier: "BGTransferService.BackGroundSession")
        return URLSession(configuration: config, delegate: self , delegateQueue: nil)
    }()
    
    func startDownload(){
        if let url = URL(string: "https://speed.hetzner.de/100MB.bin"){
            var task = urlSession.downloadTask(with: url)
            task.resume()
        }
    }
}

extension BGTransferController:URLSessionDownloadDelegate{
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download completed \(location)")
        DispatchQueue.main.async {
            self.completed?(location)
        }
        
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else {return }
        
        let progress = Double(Double(totalBytesWritten)/Double(totalBytesExpectedToWrite))
               print("Download progress: \(progress)")
               DispatchQueue.main.async {
                   self.onProgress?(progress)
               }
        
        
    }
}

extension BGTransferController : URLSessionDelegate{
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.bgURLSessionCompletedHandler
                else {
                    return
            }
            appDelegate.bgURLSessionCompletedHandler = nil
            completionHandler()
        }
    }
    
}

