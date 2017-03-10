//
//  LibraryListViewController.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import UIKit
import ReSwift

class LibraryListViewController: UIViewController, StoreSubscriber, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView(frame:windowFrame())
    private var libraryList:[Library] = []
    private let statusLabel = UILabel()
    private let reloadButton = UIButton()
    private let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // storeの通知を受け取る
        mainStore.subscribe(self)
        
        setupTableView()
        setupFooterView()
        
        let loadAction = ActionCreator.loadLibraries()
        mainStore.dispatch(loadAction)
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = 64
        view.addSubview(tableView)
    }
    
    private func setupFooterView(){
        let frame = CGRect(x: 0, y: windowHeight() - 64, width: windowWidth(), height: 64)
        let footerView = UIView(frame:frame)
        view.addSubview(footerView)
        
        let bg = UIView()
        bg.frame.size = frame.size
        bg.backgroundColor = UI.toolBarColor
        bg.alpha = 0.9
        footerView.addSubview(bg)
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: windowWidth(), height: 1))
        line.backgroundColor = UI.lineColor
        footerView.addSubview(line)
        
        reloadButton.frame = CGRect(x: windowWidth()-100-10, y: 10, width: 100, height: 44)
        reloadButton.layer.cornerRadius = 5
        reloadButton.layer.borderColor = UI.mainColor.cgColor
        reloadButton.layer.borderWidth = 1
        reloadButton.setTitleColor(UI.mainColor, for: .normal)
        reloadButton.backgroundColor = UIColor.white
        reloadButton.setTitle("読み込み", for: .normal)
        reloadButton.addTarget(self, action: #selector(LibraryListViewController.tapReload), for: .touchUpInside)
        footerView.addSubview(reloadButton)
        
        statusLabel.frame = CGRect(x: 10, y: 10, width: 200, height: 44)
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.textColor = UI.textColor
        footerView.addSubview(statusLabel)
        
        loadingIndicator.frame = CGRect(x: (windowWidth()-44) / 2, y: 10, width: 44, height: 44)
        footerView.addSubview(loadingIndicator)
    }
    
    private dynamic func tapReload(){
        print("tapReload")
        let loadAction = ActionCreator.loadLibraries()
        mainStore.dispatch(loadAction)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: StoreSubscriber
    
    func newState(state: AppState) {
        
        print("newState:\(state)")
        
        // update View //
        
        // error
        if let errorMessage = state.errorMessage{
            reloadButton.isEnabled = true
            reloadButton.alpha = 1.0
            statusLabel.text = errorMessage
            statusLabel.textColor = UI.redColor
            loadingIndicator.stopAnimating()
            return;
        }
        
        statusLabel.textColor = UI.textColor
        
        // loading
        if state.isLoading{
            reloadButton.isEnabled = false
            reloadButton.alpha = 0.5
            statusLabel.text = "Loading..."
            loadingIndicator.startAnimating()
            return;
        }
        
        // loaded
        reloadButton.isEnabled = true
        reloadButton.alpha = 1.0
        statusLabel.text = ""
        loadingIndicator.stopAnimating()
        
        self.libraryList = state.libraryList
        tableView.reloadData()
    }

    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier:String = "LibraryCell"
        var cell:LibraryCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! LibraryCell?
        
        if cell == nil {
            cell = LibraryCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        let library = libraryList[indexPath.row]
        cell?.reload(library: library)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let library = libraryList[indexPath.row]
        print("select:\(library.name())")
    }
    
}
