//
//  CalilReducer.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import ReSwift

// the reducer is responsible for evolving the application state based
// on the actions it receives
struct CalilReducer: Reducer {
    typealias ReducerStateType = AppState
    
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        
        var state = state ?? AppState()
        
        switch action {
        case _ as LibraryListLoadAction:
            
            state.errorMessage = nil
            state.isLoading = true
            
        case _ as LibraryListFailLoadAction:
            state.errorMessage = "読み込みに失敗しました"
            state.isLoading = false
            
        case let action as LibraryListLoadedAction:
            state.errorMessage = nil
            state.libraryList = action.libraryList
            state.isLoading = false
            
        default:
            break
        }
        
        return state
    }
    
}
