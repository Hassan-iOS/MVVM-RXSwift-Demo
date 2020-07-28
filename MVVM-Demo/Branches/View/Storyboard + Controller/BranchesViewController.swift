//
//  BranchesViewController.swift
//  MVVM-Demo
//
//  Created by Hassan Mostafa on 7/27/20.
//  Copyright © 2020 Hassan Mostafa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BranchesViewController: UIViewController {
    
    @IBOutlet weak var branchesTableView: UITableView!
    @IBOutlet weak var branchesContainerView: UIView!
    
    let branchTableViewCell = "BranchTableViewCell"
    let branchesViewModel = BranchesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToBranchSelection()
        setupTableView()
        bindToHiddenTable()
        subscribeToLoading()
        subscribeToResponse()
        getBranches()
        
    }
    func setupTableView() {
        //branchesTableView.dataSource = self
        branchesTableView.register(UINib(nibName: branchTableViewCell, bundle: nil), forCellReuseIdentifier: branchTableViewCell)
    }
    func bindToHiddenTable() {
        branchesViewModel.isTableHiddenObservable.bind(to: self.branchesContainerView.rx.isHidden).disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        branchesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToResponse() {
        self.branchesViewModel.branchesModelObservable
            .bind(to: self.branchesTableView
                .rx
                .items(cellIdentifier: branchTableViewCell,
                       cellType: BranchTableViewCell.self)) { row, branch, cell in
                        print(row)
                        cell.textLabel?.text = branch.name
        }
        .disposed(by: disposeBag)
    }
    func subscribeToBranchSelection() {
        Observable
            .zip(branchesTableView.rx.itemSelected, branchesTableView.rx.modelSelected(Branch.self))
            .bind { [weak self] selectedIndex, branch in
                
                print(selectedIndex, branch.name ?? "")
        }
        .disposed(by: disposeBag)
    }
    func getBranches() {
        branchesViewModel.getData()
    }
}
