//
//  ViewController.swift
//  BGTransferService
//
//  Created by Thiyagarajan Renganathan on 23/11/19.
//  Copyright © 2019 Thiyagarajan Renganathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let bgTransferController = BGTransferController()
    
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var lblFileLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgTransferController.completed = { (location) in
            print("Download finished: \(location.absoluteString)")
            self.lblFileLocation.text = location.absoluteString
        }
        
        bgTransferController.onProgress = { (progressValue) in
             self.progressView.progress = Float(progressValue)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    @IBAction func onDownload(_ sender: UIButton) {
        bgTransferController.startDownload()
    }
}

