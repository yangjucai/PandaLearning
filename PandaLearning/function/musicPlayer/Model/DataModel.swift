//
//  DataModel.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/9/3.
//

import UIKit

struct Track {
    var trackName: String
    var artistName: String
    var primaryGenreName: String
    var previewUrl: URL?
    var artworkUrl100 : URL?
    var collectionName: String
    var trackTimeMillis: String?
    var isDownloaded: Bool = false
}
