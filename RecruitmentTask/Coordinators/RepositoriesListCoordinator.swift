//
//  RepositoriesListCoordinator.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit

final class RepositoriesListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let repositoriesListViewController = RepositoriesListViewController()
        let repositoriesListViewModel = RepositoriesListViewModel()
        repositoriesListViewModel.coordinator = self
        repositoriesListViewController.viewModel = repositoriesListViewModel
        navigationController.setViewControllers([repositoriesListViewController], animated: false)
    }
    
    func selectRepository(_ repository: Repositories){
        let repositoryDetailsCoordinator = RepositoryDetailsCoordinator(
            repository: repository,
            navigationController: navigationController)
        repositoryDetailsCoordinator.parentCoordinator = self
        childCoordinators.append(repositoryDetailsCoordinator)
        repositoryDetailsCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
}


