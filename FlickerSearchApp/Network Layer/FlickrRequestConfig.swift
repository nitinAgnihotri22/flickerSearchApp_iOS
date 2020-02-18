//
//  FlickrRequestConfig.swift
//  FlickerSearchApp
//
//  Created by Nitin Agnihotri on 2/12/20.
//  Copyright © 2020 Nitin Mac. All rights reserved.
//

import UIKit

enum FlickrRequestConfig {
    
    case searchRequest(String, Int)
    
    var value: Request? {
        
        switch self {
        case .searchRequest(let searchText, let pageNo):
            let urlString = String(format: FlickrConstants.searchURL, searchText, pageNo)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}
