
//
//  JSONFetch.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//
import Alamofire
import ObjectMapper
import Cache


struct YoutubeParser {
    var title: String?
    var id: String?
    var imageLink: String?
    var date: String?
    var description: String?
    //    var releaseDate: String
    
    init?(map: Map) {
        
    }
    
    
    
    static func getPlaylistVideos(id: String, count: Int, callback: @escaping ([YoutubeParser]?, Error?) -> Void ){
        let cache = HybridCache(name: "Fetch")
        let json: JSON? = cache.object(forKey: "playlist\(id)")
        if json != nil {
             let feeds = Mapper<YoutubeParser>().mapArray(JSONObject: json?.object)
            
            callback(feeds, nil)
        }
        else {
                let url = "https://www.googleapis.com/youtube/v3/playlistItems"
                
                let params: [String: Any] = [
                    "playlistId" : id,
                    "part" : "snippet",
                    "maxResults" : count,
                    "key" : "AIzaSyD9ZBmCmTTKhwBlBVp2_dS1GO5O1EEepnk"]
                
                Alamofire.request(url, parameters: params).responseJSON { response in
                    guard let json = response.result.value as? [String: Any]
                        else {
                            callback(nil, response.result.error)
                            return
                    }
                    
                    let feed = json["items"]
                    let feeds = Mapper<YoutubeParser>().mapArray(JSONObject: feed)
                    do {
                        try cache.addObject(JSON.array(feeds!.toJSON()), forKey: "playlist\(id)")
                    }
                    catch {
                        print("Error")
                    }
                    callback(feeds, nil)
            }
        
        }
    }
    
    static func searchVideos(query: String, count: Int, callback: @escaping ([YoutubeParser]?, Error?) -> Void ){
        let url = "https://www.googleapis.com/youtube/v3/search"
        
        let params: [String: Any] = [
            "q" : query,
            "type" : "video",
            "part" : "snippet",
            "maxResults" : count,
            "order" : "relevance",
            "key" : "AIzaSyALt-cOcW-BfPNcUG15Sfv_LTsZdxqpJ64"]
        
        Alamofire.request(url, parameters: params).responseJSON { response in
            guard let json = response.result.value as? [String: Any]
                else {
                    callback(nil, response.result.error)
                    return
            }
            
            let feed = json["items"]
            let feeds = Mapper<YoutubeParser>().mapArray(JSONObject: feed)
            
            callback(feeds, nil)
        }
    }
    static func getVideo(id: String, callback: @escaping ([YoutubeVideo]?, Error?) -> Void ){
        let cache = HybridCache(name: "Fetch")
        let json: JSON? = cache.object(forKey: "video\(id)")
        if json != nil {
            let feeds = Mapper<YoutubeVideo>().mapArray(JSONObject: json?.object)
            
            callback(feeds, nil)
        }
        else {
        let url = "https://www.googleapis.com/youtube/v3/videos"
        let params: [String: Any] = [
            "id" : id,
            "part" : "statistics",
            "key" : "AIzaSyALt-cOcW-BfPNcUG15Sfv_LTsZdxqpJ64"]
        Alamofire.request(url, parameters: params).responseJSON { response in
            guard let json = response.result.value as? [String: Any]
                else {
                    callback(nil, response.result.error)
                    return
            }
            
            let feed = json["items"]
            let feeds = Mapper<YoutubeVideo>().mapArray(JSONObject: feed)
            do {
                try cache.addObject(JSON.array(feeds!.toJSON()), forKey: "video\(id)")
            }
            catch {
                print("Error")
            }
            callback(feeds, nil)
            }
        }
    }
//
//    static func getPlaylists(count: Int, callback: @escaping ([ChannelPlaylists]?, Error?) -> Void ){
//        let url = "https://www.googleapis.com/youtube/v3/playlists"
// 
//        let params: [String: Any] = [
//            "channelId" : "UC9xj5GKA0-Dr_filKO9YbnA",
//            "part" : "snippet",
//            "maxResults" : count,
//            "key" : "AIzaSyALt-cOcW-BfPNcUG15Sfv_LTsZdxqpJ64"]
//        
//        Alamofire.request(url, parameters: params).responseJSON { response in
//            guard let json = response.result.value as? [String: Any]
//                else {
//                    callback(nil, response.result.error)
//                    return
//            }
//            
//            let feed = json["items"]
//            let feeds = Mapper<ChannelPlaylists>().mapArray(JSONObject: feed)
//            
//            callback(feeds, nil)
//        }
//    }
    
   }

struct YoutubeVideo: Mappable {
    var viewCount: String?
    var likeCount: String?
    var dislikeCount: String?
    var commentCount: String?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        viewCount <- map["statistics.viewCount"]
        likeCount <- map["statistics.likeCount"]
        dislikeCount <- map["statistics.dislikeCount"]
        commentCount <- map["statistics.commentCount"]
    }
}



    
extension YoutubeParser: Mappable {
    mutating func mapping(map: Map) {
        title <- map["snippet.title"]
        id <- map["snippet.resourceId.videoId"]
        imageLink <- map["snippet.thumbnails.medium.url"]
        date <- map["snippet.publishedAt"]
        description <- map["snippet.description"]
    }
}
