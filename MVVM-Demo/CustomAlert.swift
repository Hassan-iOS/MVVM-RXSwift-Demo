//
//  CustomAlert.swift
//  MVVM-Demo
//
//  Created by Hassan Mostafa on 7/25/20.
//  Copyright © 2020 Hassan Mostafa. All rights reserved.
//

import Foundation
import CleanyModal

class MyAlertViewController: CleanyAlertViewController {

    init(title: String?, message: String?, imageName: String? = nil, preferredStyle: CleanyAlertViewController.Style = .alert) {
        let styleSettings = CleanyAlertConfig.getDefaultStyleSettings()
        styleSettings[.cornerRadius] = 18
        super.init(title: title, message: message, imageName: imageName, preferredStyle: preferredStyle, styleSettings: styleSettings)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
