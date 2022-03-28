//
//  RootViewController.swift
//  iPhone-App-Base
//
//  Created by 小森　武史 on 2022/03/27.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    public var viewModel: RootViewModelType!
    private let disposeBag = DisposeBag()
    
    weak var delegate: RootCoordinatorDegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bindViewModelInputs()
        bindViewModelOutputs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.viewDidAppear.accept(())
    }
    
    private func bindViewModelInputs() {}
    
    private func bindViewModelOutputs() {
        viewModel
            .outputs
            .isLoading
            .drive(onNext: { state in
                
            })
            .disposed(by: disposeBag)
        
        viewModel
            .outputs
            .openMainTabBar
            .emit(onNext: {
                self.delegate?.coordinateToMainTabBar()
            })
            .disposed(by: disposeBag)
    }
}
