//
//  ImageHandler.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/9/3.
//

import UIKit

class ImageHandler {
    
    static var sharedInstance = ImageHandler()
    
    private init() {}
    
    var image : UIImage?
    var updatedTrack: Int = 0
    
    func showTrackImage(imageURL: URL) -> UIImage {
        do {
            let data = try Data(contentsOf: imageURL)
            image = UIImage(data: data)
        }
        catch {
            print(error)
        }
        return image!
    }
}
