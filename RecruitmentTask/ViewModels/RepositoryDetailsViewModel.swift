//
//  RepositoryDetailsViewModel.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import Foundation

final class RepositoryDetailsViewModel {
    
    var onUpdate: (()->())?
    var coordinator: RepositoryDetailsCoordinator?
    
    var repository: Repositories?
    var commits: [CommitsHistory]?
    
    func fetchCommits(repository: Repositories?) {
        APIManager.shared.fetchCommits(repository: repository) { [weak self] result in
            switch result {
            case .success(let commits):
                self?.commits = Array(commits.prefix(3))
                self?.onUpdate?()
                break
            case .failure(_):
                break
            }
        }
    }
    
    func didFinish(){
        coordinator?.didFinish()
    }

}
