//
//  BranchesViewModel.swift
//  MVVM-Demo
//
//  Created by Hassan Mostafa on 7/27/20.
//  Copyright © 2020 Hassan Mostafa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class BranchesViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    private var branchesModelSubject = PublishSubject<[Branch]>()
    
    var branchesModelObservable: Observable<[Branch]> {
        return branchesModelSubject
    }
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    
    func getData() {
        loadingBehavior.accept(true)
        APIServices.instance.getData(url: "https://b-andsweets.com/api/list-branches", method: .get, params: nil, encoding: JSONEncoding.default, headers: nil) { [weak self](branchesModel: BranchesModel?, errorModel: BaseErrorModel?, error) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            if let error = error {
                print(error.localizedDescription)
            } else if let errorModel = errorModel {
                print(errorModel.message ?? "")
            } else {
                guard let branchesModel = branchesModel else { return }
                if branchesModel.data?.count ?? 0 > 0 {
                    self.branchesModelSubject.onNext(branchesModel.data ?? [])
                    self.isTableHidden.accept(false)
                } else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
