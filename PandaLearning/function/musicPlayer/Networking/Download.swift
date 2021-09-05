//
//  Download.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/9/3.
//

import UIKit

class Download {
    var track: Track?
    
    init(currentTrack: Track) {
        self.track = currentTrack
    }
    
    var downloadTask: URLSessionDownloadTask?
    var isDownloading = false
    var isDownloaded = false
    var resumeData: Data?
    var progress: Float = 0
}
