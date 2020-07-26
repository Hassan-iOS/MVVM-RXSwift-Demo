//
//  BaseErrorModel.swift
//  MVVM-Demo
//
//  Created by Hassan Mostafa on 7/25/20.
//  Copyright © 2020 Hassan Mostafa. All rights reserved.
//

import Foundation

struct BaseErrorModel: Codable {
    let message: String?
    let status_code: Int?
}
