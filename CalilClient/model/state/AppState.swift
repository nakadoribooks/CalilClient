//
//  AppState.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    var isLoading:Bool = false
    var libraryList:[Library] = []
    var errorMessage:String?
}
