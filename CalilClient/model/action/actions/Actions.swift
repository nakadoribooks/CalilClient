//
//  Actions.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import ReSwift

struct LibraryListLoadAction:Action {}
struct LibraryListFailLoadAction:Action{}
struct LibraryListLoadedAction:Action{
    let libraryList:[Library]
}
