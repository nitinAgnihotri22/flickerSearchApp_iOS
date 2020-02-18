//
//  Photos.swift
//  FlickerSearchApp
//
//  Created by Nitin Agnihotri on 2/12/20.
//  Copyright © 2020 Nitin Mac. All rights reserved.
//

import UIKit

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [FlickrPhoto]
    let total: String
    
    /*enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case photo
        case total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        pages = try container.decode(Int.self, forKey: .pages)
        perpage = try container.decode(Int.self, forKey: .perpage)
        photo = try container.decode([FlickrPhoto].self, forKey: .photo)
        total = try container.decode(String.self, forKey: .total)
    }*/
}
