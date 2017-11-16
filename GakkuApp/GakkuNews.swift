
//
//  JSONFetch.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//
import Alamofire
import ObjectMapper

struct GakkuApi {
    var title: String?
    var imageLink: String?
    var url: String?
    var content: String?

    init?(map: Map) {
        
    }
    static func get(page: Int, callback: @escaping ([GakkuApi]?, Error?) -> Void ){
        let url = "http://api.bulbul.su/get.php"
        
        let params: [String: Any] = [
            "page" : page,
            "type" : "getnews"
        ]
        
        Alamofire.request(url, parameters: params).responseJSON { response in
 
            guard let json = response.result.value
                else {
                    callback(nil, response.result.error)
                    return
            }
             let feeds = Mapper<GakkuApi>().mapArray(JSONObject: json)
            
            callback(feeds, nil)
        }
    }
    static func getTVProgramms(callback: @escaping ([GakkuTVProgramms]?, Error?) -> Void ){
        let url = "http://api.bulbul.su/getTv.php"
        
        let params: [String: Any] = [
            "type" : "gettvprogramms"
        ]
        
        Alamofire.request(url, parameters: params).responseJSON { response in
            
            guard let json = response.result.value
                else {
                    callback(nil, response.result.error)
                    return
            }
             let feeds = Mapper<GakkuTVProgramms>().mapArray(JSONObject: json)
            
            callback(feeds, nil)
        }
    }
}


struct GakkuTVProgramms:Mappable {
    var name: String?
    var date: String?
    var about: String?
    //    var releaseDate: String
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        name <- map["name"]
        date <- map["date"]
        about <- map["about"]
    }
}

extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
    
}
extension GakkuApi: Mappable {
    mutating func mapping(map: Map) {
        title <- map["title"]
        imageLink <- map["img"]
        url <- map["url"]
        content <- map["html"]
    }
}
