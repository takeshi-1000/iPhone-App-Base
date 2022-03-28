//
//  FirstViewModel.swift
//  coordinatorPractice
//
//  Created by 小森　武史 on 2022/03/27.
//

import RxCocoa
import RxSwift

protocol GithubRepoListViewModelInputType {
    var viewDidLoad: PublishRelay<Void> { get }
}

protocol GithubRepoListViewModelOutputType {
    var repositories: Driver<[GithubRepositoryEntity]> { get }
    var showError: Signal<Error> { get }
    var isLoading: Driver<Bool> { get }
}

protocol GithubRepoListViewModelType {
    var inputs: GithubRepoListViewModelInputType { get }
    var outputs: GithubRepoListViewModelOutputType { get }
}

class GithubRepoListViewModel: GithubRepoListViewModelType, GithubRepoListViewModelInputType, GithubRepoListViewModelOutputType {
    var inputs: GithubRepoListViewModelInputType { self }
    var outputs: GithubRepoListViewModelOutputType { self }
    
    let disposeBag = DisposeBag()
    
    let stateMachine: GithubRepoListStateMachine
    
    // MARK: inputs
    let viewDidLoad = PublishRelay<Void>()
    
    // MARK: outputs
    var showError: Signal<Error> { _showError.asSignal() }
    var isLoading: Driver<Bool> { _isLoading.asDriver(onErrorJustReturn: false) }
    var repositories: Driver<[GithubRepositoryEntity]> { _repositories.asDriver(onErrorJustReturn: []) }
    
    private let _showError = PublishRelay<Error>()
    private let _isLoading = PublishRelay<Bool>()
    private let _repositories = PublishRelay<[GithubRepositoryEntity]>()
    
    init(stateMachine: GithubRepoListStateMachine) {
        self.stateMachine = stateMachine
        
        bindInputs()
        bindStateMachineOutputs()
    }
    
    private func bindInputs() {
        viewDidLoad
            .map { GithubRepoListAction.fetch }
            .bind(to: stateMachine.action)
            .disposed(by: disposeBag)
        
        stateMachine
            .state
            .subscribe(onNext: {
                self.handleState($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindStateMachineOutputs() {
        stateMachine
            .outputs
            .state
            .subscribe(onNext: {
                self.handleState($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleState(_ state: GithubRepoListState) {
        switch state {
        case .none: break
        case .loading:
            _isLoading.accept(true)
        case .succeed(let repositories):
            _repositories.accept(repositories)
        case .failed(let error):
            _showError.accept(error)
        }
    }
}
