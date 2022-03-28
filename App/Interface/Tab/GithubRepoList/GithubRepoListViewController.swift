//
//  FirstViewController.swift
//  iPhone-App-Base
//
//  Created by 小森　武史 on 2022/03/27.
//

import UIKit
import RxSwift

class GithubRepoListViewController: UIViewController {
    
    var viewModel: GithubRepoListViewModelType!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 20))
        label.text = "first"
        label.textColor = .black
        view.addSubview(label)
        
        view.backgroundColor = .white
        
        viewModel.inputs.viewDidLoad.accept(())
        
        bindViewModelInputs()
    }
    
    private func bindViewModelInputs() {
        
    }
    
    private func bindViewModelOutputs() {
//        viewModel
//            .outputs
//            .isLoading
//            .drive(<#T##observers: ObserverType...##ObserverType#>)
//            .disposed(by: disposeBag)
//
//        viewModel
//            .outputs
//            .showError
//            .emit(to: <#T##ObserverType...##ObserverType#>)
//            .disposed(by: disposeBag)
    }
}
