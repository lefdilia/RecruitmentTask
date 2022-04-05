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
    
    func selectRepository(){
        
        let repositoryDetailsCoordinator = RepositoryDetailsCoordinator(navigationController: navigationController)
        repositoryDetailsCoordinator.parentCoordinator = self
        childCoordinators.append(repositoryDetailsCoordinator)
        repositoryDetailsCoordinator.start()
        
    }
    
}


