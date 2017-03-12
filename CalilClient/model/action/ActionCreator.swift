//
//  ActionCreator.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import ReSwift
import Alamofire
import PromiseKit

struct ActionCreator{
    
    static func loadLibraries(prefName:String="秋田県")-> Promise<Action>{
        
        return Promise { fulfill, reject in
            
            let parameters: Parameters = ["appkey": Config.API_KEY, "pref":prefName, "format":"json", "callback":""]
            
            Alamofire.request(Config.API_LIBRARY, parameters: parameters).responseJSON().then { responseAny -> Void in
                
                guard let json = responseAny as? [NSDictionary] else{
                    print("fail json")
                    
                    let failAction = LibraryListFailLoadAction()
                    fulfill(failAction)
                    return
                }
                
                print("ok json")
                let results = Library.createList(list: json)
                let loadedAction = LibraryListLoadedAction(libraryList: results)
                
                // 時間かかっているてい
                DispatchQueue.global(qos: .default).async {
                    Thread.sleep(forTimeInterval: 1)
                    DispatchQueue.main.async {
                        fulfill(loadedAction)
                    }
                }
                
            }.catch { error in
                let failAction = LibraryListFailLoadAction()
                fulfill(failAction)
            }
            
        }
        
    }
    
    static func loadLibrariesAction()->Action{
        return LibraryListLoadAction()
    }
    
}
