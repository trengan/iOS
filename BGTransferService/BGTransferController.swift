//
//  BGTransferController.swift
//  BGTransferService
//
//  Created by Thiyagarajan Renganathan on 24/11/19.
//  Copyright © 2019 Thiyagarajan Renganathan. All rights reserved.
//

import Foundation

public class BGTransferController: NSObject{
    
     private lazy var  urlSession : URLSession = {
        var config = URLSessionConfiguration.background(withIdentifier: "BGTransferService.BackGroundSession")
        return URLSession(configuration: config, delegate: self , delegateQueue: nil)
    }()
}

extension BGTransferController:URLSessionDownloadDelegate{
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    
    }
}

extension BGTransferController : URLSessionDelegate{
    
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
    
}

