//
//  LoginViewModel.swift
//  MVVM-Demo
//
//  Created by Hassan Mostafa on 7/25/20.
//  Copyright © 2020 Hassan Mostafa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel {
    
    var codeBehavior = BehaviorRelay<String>(value: "")
    var phoneBehavior = BehaviorRelay<String>(value: "")
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var loginModelSubject = PublishSubject<LoginSuccessModel>()
    
    var isPhoneValid: Observable<Bool> {
        return phoneBehavior.asObservable().map { (phone) -> Bool in
            let isPhoneEmpty = phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            
            return isPhoneEmpty
        }
    }
    var isCodeValid: Observable<Bool> {
        return codeBehavior.asObservable().map {(code) -> Bool in
            let isCodeEmpty = code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isCodeEmpty
        }
    }
    var isLoginButtonEnapled: Observable<Bool> {
        return Observable.combineLatest(isPhoneValid, isCodeValid) { (isPhoneEmpty, isCodeEmpty) in
            let loginValid = !isPhoneEmpty && !isCodeEmpty
            return loginValid
        }
    }
    var loginModelObservable: Observable<LoginSuccessModel> {
        return loginModelSubject
    }
    
    
    func getData() {
        loadingBehavior.accept(true)
        let params = [
            "phone": phoneBehavior.value,
            "password": codeBehavior.value,
            "player_id": "a0fb941c-ba42-450d-9a09-4e38258f5adb"
        ]
        let headers = ["Content-Type": "application/json"]
        APIServices.instance.getData(url: "https://b-andsweets.com/api/login", method: .post, params: params, encoding: JSONEncoding.default, headers: headers) { [weak self](loginModel: LoginSuccessModel?, baseErrorModel: BaseErrorModel?, error) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = error {
                // network error
                print(error.localizedDescription)
            } else if let baseErrorModel = baseErrorModel {
                print(baseErrorModel.message ?? "")
            } else {
                guard let loginModel = loginModel else { return }
                self.loginModelSubject.onNext(loginModel)
            }
        }
    }
}
