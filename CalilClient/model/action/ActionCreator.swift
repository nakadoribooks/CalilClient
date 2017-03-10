//
//  ActionCreator.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import ReSwift
import Alamofire

struct ActionCreator{
    
    static func loadLibraries(prefName:String="秋田県")->Action{
        let parameters: Parameters = ["appkey": Config.API_KEY, "pref":prefName, "format":"json", "callback":""]
        
        Alamofire.request(Config.API_LIBRARY, parameters: parameters).responseJSON { (response) in
            guard let json = response.result.value as? [NSDictionary] else{
                print("fail json")
                print(response)
                let loadFailAction = LibraryListFailLoadAction()
                mainStore.dispatch(loadFailAction)
                return
            }
            
            print("ok json")
            let results = Library.createList(list: json)
            let loadedAction = LibraryListLoadedAction(libraryList: results)
            
            // mainStore.dispatch(loadedAction)
            
            // 時間かかっているてい
            DispatchQueue.global(qos: .default).async {
                Thread.sleep(forTimeInterval: 1)
                DispatchQueue.main.async {
                    mainStore.dispatch(loadedAction)
                }
            }
        }
        
        
        return LibraryListLoadAction()
    }
    
}
