//
//  UI.swift
//  CalilClient
//
//  Created by kawase yu on 2017/03/10.
//  Copyright © 2017年 u kawse. All rights reserved.
//

import UIKit

func windowWidth()->CGFloat{
    return windowSize().width
}

func windowHeight()->CGFloat{
    return windowSize().height
}

func windowSize()->CGSize{
    return windowFrame().size
}

func windowFrame()->CGRect{
    return UIScreen.main.bounds
}

func colorFromHex(hexStr : String, alpha : CGFloat = 1.0) -> UIColor {
    let hexStr = hexStr.replacingOccurrences(of: "#", with: "")
    let scanner = Scanner(string: hexStr as String)
    var color: UInt32 = 0
    if scanner.scanHexInt32(&color) {
        let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(color & 0x0000FF) / 255.0
        return UIColor(red:r,green:g,blue:b,alpha:alpha)
    } else {
        print("invalid hex string")
        return UIColor.white;
    }
}

class UI: NSObject {

    static let baseColor = colorFromHex(hexStr: "2c3e50")
    static let mainColor = colorFromHex(hexStr: "27ae60")
    static let accentColor = colorFromHex(hexStr: "e67e22")
    static let grayColor = colorFromHex(hexStr: "95a5a6")
    static let textColor = colorFromHex(hexStr: "2c3e50")
    static let lineColor = colorFromHex(hexStr: "34495e")
    static let redColor = colorFromHex(hexStr: "e74c3c")
    
    static let toolBarColor = colorFromHex(hexStr: "ffffff", alpha: 0.95)
    
}
