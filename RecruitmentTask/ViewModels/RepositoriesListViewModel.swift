//
//  RepositoriesListViewModel.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import Foundation

final class RepositoriesListViewModel {
    
    var onUpdate: (()->())?
    var coordinator: RepositoriesListCoordinator?
    
    let title = "Search"
    var repositories: [Repositories]?
    
    func didSelectRepository(_ repository: Repositories){
        coordinator?.selectRepository(repository)
    }
    
    func fetchRepositories(keyword: String, page: Int = 1){
        APIManager.shared.fetchRepositories(keyword: keyword, page: page) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                self?.onUpdate?()
                break
            case .failure(_):
                break
            }
        }
    }
}
