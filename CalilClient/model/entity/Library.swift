//
//  Library.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import UIKit

class Library: NSObject {

    // MARK:  static
    
    static func createList(list:[NSDictionary])->[Library]{
        var result:[Library] = []
        
        for dic in list {
            let library = Library(dic: dic)
            result.append(library)
        }
        
        return result
    }
    
    // MARK: instance
    
    let dic:NSDictionary
    
    init(dic:NSDictionary) {
        self.dic = dic
        super.init()
    }
    
    func address()->String{
        if let v = dic.object(forKey: "address") as? String{
            return v
        }
        
        return ""
    }
    
    func name()->String{
        
        if let v = dic.object(forKey: "formal") as? String{
            return v
        }
        
        return ""
    }
    
    func libId()->String?{
        
        if let v = dic.object(forKey: "libid") as? String{
            return v
        }
        
        return nil
    }

}
