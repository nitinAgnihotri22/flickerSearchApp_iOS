//
//  FlickrSearchResults.swift
//  FlickerSearchApp
//
//  Created by Nitin Agnihotri on 2/12/20.
//  Copyright © 2020 Nitin Mac. All rights reserved.
//

import UIKit

struct FlickrSearchResults: Codable {
    let stat: String?
    let photos: Photos?
    
    /*enum CodingKeys: String, CodingKey {
        case stat
        case photos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stat = try container.decodeIfPresent(String.self, forKey: .stat)
        photos = try container.decodeIfPresent(Photos.self, forKey: .photos)
    }*/
}
