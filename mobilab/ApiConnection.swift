//
//  ApiConnection.swift
//  mobilab
//
//  Created by Arilson do Carmo on 4/18/16.
//  Copyright © 2016 Arilson do Carmo. All rights reserved.
//

import Foundation
import Alamofire

class ApiConnection {
    var headers: [String:String]
    var endpoint: String = ""
    var page: Int = 0
    var limit: Int = 20
    
    init(){
        headers = [
            "Content-type": "application/json",
            "Authorization": ApiConstants.ImgUrCredentials.ClientId
        ]
        endpoint = ApiConstants.ImgurApi.BaseUrl
        limit = 30
    }
    
    func createRequestPath(requestPath: String! ) -> String {
        if requestPath != nil {
            endpoint = endpoint + requestPath + "perPage=" + String(limit) + "&page=" + String(page)
        }
        return endpoint
    }
    
    func getImagesByType(increment: Bool, type: String, completion: ([PictureModel]?, NSError?) -> ()) {
        if increment {
            page += 1
        } else {
            page = 1
        }
        
        let request =  createRequestPath("gallery/" + type + "/")
        
        Alamofire.request(.GET, request, headers: headers).responseJSON { response in
            switch response.result {
            case .Success:
                if let entries = response.result.value as? [String: AnyObject] {
                    var list: [PictureModel] = []
                    let data = entries["data"] as! [[String: AnyObject]]
                    for entry in data {
                        if let s = PictureModel(data: entry) {
                           list.append(s)
                        }
                    }
                    completion(list, nil)
                }
            case .Failure(let error):
                completion(nil, error)
            }
        }
    }
    
}