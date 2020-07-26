//
//  LoginSuccessModel.swift
//  MVVM-Demo
//
//  Created by Hassan Mostafa on 7/25/20.
//  Copyright © 2020 Hassan Mostafa. All rights reserved.
//



import Foundation

// MARK: - LoginSuccessModel
struct LoginSuccessModel: Codable {
    let data: DataClass?
    let statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case data
        case statusCode = "status_code"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let phone: String?
    let revenue: Revenue?
    let token: String?
    let hasUnreadNotifications: Bool?
    let family: Family?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, revenue, token
        case hasUnreadNotifications = "has_unread_notifications"
        case family
    }
}

// MARK: - Family
struct Family: Codable {
    let nationalID, storeName: String?
    let commercialRegistrationNo, storePhone, instagramURL, snapURL: String?
    let twitterURL: String?
    let bankName, ibanNo, bankAccountOwnerName: String?
    let code: Int?
    let city: City?

    enum CodingKeys: String, CodingKey {
        case nationalID = "national_id"
        case storeName = "store_name"
        case commercialRegistrationNo = "commercial_registration_no"
        case storePhone = "store_phone"
        case instagramURL = "instagram_url"
        case snapURL = "snap_url"
        case twitterURL = "twitter_url"
        case bankName = "bank_name"
        case ibanNo = "IBAN_no"
        case bankAccountOwnerName = "bank_account_owner_name"
        case code, city
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Revenue
struct Revenue: Codable {
    let afterMerchantPercentage, beforeMerchantPercentage: Int?

    enum CodingKeys: String, CodingKey {
        case afterMerchantPercentage = "after_merchant_percentage"
        case beforeMerchantPercentage = "before_merchant_percentage"
    }
}
