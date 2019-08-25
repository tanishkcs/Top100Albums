//
//  AddItem.swift
//  top100Albums
//
//  Created by IMCS2 on 8/21/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import Foundation
import UIKit

class addItem {
    
    private var items: itemModelArray
    private var errorMsg: String = ""
    public var itemStoreArray: [itemModel]
    var savedArtistNameArray: [String]
    var savedAlbumNameArray: [String]
    var savedThumbnailImageUrl: [String]
    var savedGenre: [String]
    var savedReleaseDate: [String]
    var savedCopyrightInfo: [String]
    var savedAlbumURLData: [String]
    
   
    var url: URL!
    
    
    init(){
        items = itemModelArray()
         url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")
        itemStoreArray = []
        savedArtistNameArray = []
        savedAlbumNameArray = []
        savedThumbnailImageUrl = []
        savedGenre = []
        savedReleaseDate = []
        savedCopyrightInfo = []
        savedAlbumURLData = []
        
        
    }
    
}
    
extension addItem {
    
    func gettingData(completionHandler: @escaping (itemModelArray) -> ()) {
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        if error == nil {
            if let unwrappedData = data {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    // print((jsonResult)!)
                    let feeds = jsonResult?["feed"] as? NSDictionary
                    let results = feeds!["results"] as? NSArray
                 
                 
                    DispatchQueue.main.async {
                        if let count = results?.count {
                            for i in 0...count-1 {
                                let getArray = results?[i] as? NSDictionary
                                
                                
                                
//                                print("this is result \(results)")
                                
                                //self.titleArray.append(getArray!["title"] as! String)
                                self.savedArtistNameArray.append(getArray!["artistName"] as! String)

                                self.savedAlbumNameArray.append(getArray!["name"] as! String)
                                self.savedThumbnailImageUrl.append(getArray!["artworkUrl100"] as! String)
                                let getGenre = getArray!["genres"] as? NSArray
                                let getArray2 = getGenre?[0] as? NSDictionary
                                self.savedGenre.append(getArray2?.value(forKey: "name") as! String)
                                self.savedReleaseDate.append(getArray!["releaseDate"] as! String)
                                self.savedCopyrightInfo.append(getArray!["copyright"] as! String)
                                self.savedAlbumURLData.append(getArray!["url"] as! String)
                   }
                            
                    print(self.savedAlbumURLData)
                            
                        }
                        
                        let item = itemModelArray(savedArtistNameArray: self.savedArtistNameArray, savedAlbumNameArray: self.savedAlbumNameArray, savedThumbnailImageUrl: self.savedThumbnailImageUrl, savedGenre: self.savedGenre, savedReleaseDate: self.savedReleaseDate, savedCopyrightInfo: self.savedCopyrightInfo, savedAlbumURLData: self.savedAlbumURLData)
                        
                        print("this is final genre \(self.savedGenre)")
                    completionHandler(item)
                      
                     // print(item.savedAlbumNameArray)
                    }
                }catch {
                   // print("error in fetching")
                }
                
            }
        }
    }
    task.resume()
        
        
    
    }
    
    
    
}
