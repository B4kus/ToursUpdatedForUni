//
//  Appearance.swift
//  Tours
//
//  Created by Szymon Szysz on 01.07.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import Foundation
import UIKit

let systemThinFont = UIFont(name: "AppleSDGothicNeo-Thin", size: 18)
let systemBoldFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 28)
let systemBlueColor = UIColor(red:0.15, green:0.64, blue:0.87, alpha:1.00)
let systemGreyColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.00)

func systemBoldFont(size: CGFloat) -> UIFont? {
    return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size)
}

func systemThinFont(size: CGFloat) -> UIFont? {
    return UIFont(name: "AppleSDGothicNeo-Thin", size: size)
}
