//
//  FlickrConstants.swift
//  FlickerSearchApp
//
//  Created by Nitin Agnihotri on 2/12/20.
//  Copyright © 2020 Nitin Mac. All rights reserved.
//

import UIKit

class FlickrConstants: NSObject {
    
    static let api_key = "425fc491b705c3a83f035666d664135a"
    static let per_page = 60
    static let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FlickrConstants.api_key)&format=json&nojsoncallback=1&safe_search=1&per_page=\(FlickrConstants.per_page)&text=%@&page=%ld"
    static let imageURL = "https://farm%d.staticflickr.com/%@/%@_%@_\(FlickrConstants.size.url_s.value).jpg"
    
    enum size: String {
        case url_sq = "s"   //small square 75x75
        case url_q = "q"    //large square 150x150
        case url_t = "t"    //thumbnail, 100 on longest side
        case url_s = "m"    //small, 240 on longest side
        case url_n = "n"    //small, 320 on longest side
        case url_m = "-"    //medium, 500 on longest side
        case url_z = "z"    //medium 640, 640 on longest side
        case url_c = "c"    //medium 800, 800 on longest side†
        case url_l = "b"    //large, 1024 on longest side*
        case url_h = "h"    //large 1600, 1600 on longest side†
        case url_k = "k"    //large 2048, 2048 on longest side†
        case url_o = "o"    //original image, either a jpg, gif or png, depending on source format
        
        var value: String {
            return self.rawValue
        }
    }
    
    static let defaultColumnCount: CGFloat = 3.0
}
