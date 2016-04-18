//
//  picture.swift
//  mobilab
//
//  Created by Arilson do Carmo on 4/18/16.
//  Copyright © 2016 Arilson do Carmo. All rights reserved.
//

import Foundation

class PictureModel {
    var title: String
    var description: String
    var link: String
    var id: String
    var up: Int = 0
    var down: Int = 0
    
    init?(data: [String: AnyObject]) {
        title = data["title"] as! String
        description = data["description"] as! String
        link = data["link"] as! String
        id = data["id"] as! String
        up = data["up"] as! Int
        down = data["down"] as! Int
    }
}