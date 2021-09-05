//
//  CreateURL.swift
//  PandaLearning
//
//  Created by yangjucai on 2021/9/3.
//

import UIKit

let BASE_URL = "https://itunes.apple.com/search?"

func createSearchString(searchKeyword: String) -> String{
    let searchString = searchKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    let urlString = "term=\(searchString!)&media=music&entity=musicTrack"
    
    return BASE_URL + urlString
}
