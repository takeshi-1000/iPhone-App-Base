//
//  GithubRepoListStateMachine.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

import RxSwift
import RxCocoa

protocol GithubRepoListStateMachineInputType {
    var action: PublishRelay<GithubRepoListAction> { get }
}

protocol GithubRepoListStateMachineOutputType {
    var state: BehaviorRelay<GithubRepoListState> { get }
}

protocol GithubRepoListStateMachineType {
    var inputs: GithubRepoListStateMachineInputType { get }
    var outputs: GithubRepoListStateMachineOutputType { get }
}

// ViewModel ↔️ StateMachine

class GithubRepoListStateMachine: GithubRepoListStateMachineType, GithubRepoListStateMachineInputType, GithubRepoListStateMachineOutputType {
    
    var inputs: GithubRepoListStateMachineInputType { self }
    var outputs: GithubRepoListStateMachineOutputType { self }
    
    let githubRepository: GithubRepositoryType
    private let disposeBag = DisposeBag()
    
    // MARK: inputs
    public let action = PublishRelay<GithubRepoListAction>()
    
    // MARK: outputs
    public var state: BehaviorRelay<GithubRepoListState> { _state }
    
    private let _state = BehaviorRelay<GithubRepoListState>(value: .none)
    
    init(githubRepository: GithubRepositoryType) {
        self.githubRepository = githubRepository
        
        bindInputs()
        bindRepositoryOutputs()
    }
    
    private func bindInputs() {
        action
            .withLatestFrom(_state, resultSelector: { action, state in
                (action, state)
            })
            .subscribe(onNext: {
                self.handleAction($0, currentState: $1)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindRepositoryOutputs() {
        githubRepository
            .outputs
            .repositoryList
            .map { GithubRepoListAction.succeedToFetch($0) }
            .bind(to: action)
            .disposed(by: disposeBag)
        
        githubRepository
            .outputs
            .error
            .map { GithubRepoListAction.failToFetch($0) }
            .bind(to: action)
            .disposed(by: disposeBag)
    }
    
    private func handleAction(_ action: GithubRepoListAction, currentState: GithubRepoListState) {
        switch action {
        case .fetch:
            if case .none = currentState {
                _state.accept(.loading)
                githubRepository.inputs.fetch.accept(())
            }
        case .succeedToFetch(let repositories):
            if case .loading = currentState {
                _state.accept(.succeed(repositories))
            }
        case .failToFetch(let error):
            if case .loading = currentState {
                _state.accept(.failed(error))
            }
        }
    }
}
