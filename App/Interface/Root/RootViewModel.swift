//
//  RootViewModel.swift
//  iPhone-App-Base
//
//  Created by 小森　武史 on 2022/03/27.
//

import RxSwift
import RxRelay
import RxCocoa

protocol RootViewModelInputType {
    var viewDidAppear: PublishRelay<Void> { get }
}

protocol RootViewModelOutputType {
    var isLoading: Driver<Bool> { get }
    var openMainTabBar: Signal<Void> { get }
}

protocol RootViewModelType {
    var inputs: RootViewModelInputType { get }
    var outputs: RootViewModelOutputType { get }
}

class RootViewModel: RootViewModelType, RootViewModelInputType, RootViewModelOutputType {
    var inputs: RootViewModelInputType { self }
    var outputs: RootViewModelOutputType { self }
    
    let stateMachine: AppStateMachine
    private let disposeBag = DisposeBag()
    
    // MARK: inputs
    let viewDidAppear = PublishRelay<Void>()
    
    // MARK: outputs
    var isLoading: Driver<Bool> { _isLoading.asDriver() }
    var openMainTabBar: Signal<Void> { _openMainTabBar.asSignal() }
    
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private let _openMainTabBar = PublishRelay<Void>()
    
    init(stateMachine: AppStateMachine) {
        self.stateMachine = stateMachine
        
        bindInputs()
    }
    
    private func bindInputs() {
        viewDidAppear
//            .take(1)
            .map { AppAction.load }
            .bind(to: stateMachine.action)
            .disposed(by: disposeBag)
    }
    
    private func bindStateMachineOutputs() {
        stateMachine.state.asObservable()
            .subscribe(onNext: {
                self.handleState($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleState(_ state: AppState) {
        switch state {
        case .none:
            break
        case .loading(let isLoading):
            _isLoading.accept(isLoading)
        case .succeed:
            _openMainTabBar.accept(())
        case .failed:
            break
        }
    }
}
