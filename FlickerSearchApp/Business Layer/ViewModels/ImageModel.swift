//
//  ImageModel.swift
//  FlickerSearchApp
//
//  Created by Nitin Agnihotri on 2/12/20.
//  Copyright © 2020 Nitin Mac. All rights reserved.
//

import UIKit

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: FlickrPhoto) {
        imageURL = photo.imageURL
    }
}
