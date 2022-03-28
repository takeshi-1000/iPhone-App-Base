//
//  AppStateMachine.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

import RxSwift
import RxRelay

protocol AppStateMachineInputType {
    var action: PublishRelay<AppAction> { get }
}

protocol AppStateMachineOutputType {
    var state: PublishRelay<AppState> { get }
}

protocol AppStateMachineType {
    var inputs: AppStateMachineInputType { get }
    var outputs: AppStateMachineOutputType { get }
}

class AppStateMachine {
    
    static let shared = AppStateMachine()
    private let disposeBag = DisposeBag()
    
    // MARK: inputs
    let action = PublishRelay<AppAction>()
    
    // MARK: outputs
    var state: PublishRelay<AppState> { _state }
    
    private let _state = PublishRelay<AppState>()
    
    init() {
        
        bindInputs()
    }
    
    private func bindInputs() {
        action
            .subscribe(onNext: {
                self.handleAction($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleAction(_ action: AppAction) {
        switch action {
        case .load:
            _state.accept(.loading(true))
            // APIリクエスト or ローカルから値取得するなど
            _state.accept(.loading(false))
            _state.accept(.succeed)
        case .login:
            break
        case .logout:
            break
        }
    }
}
