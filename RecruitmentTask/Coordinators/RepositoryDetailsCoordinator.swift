//
//  RepositoryDetailsCoordinator.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit


final class RepositoryDetailsCoordinator: Coordinator {
   
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    private(set) var repository: Repositories
    
    var parentCoordinator: RepositoriesListCoordinator?
    
    init(repository: Repositories, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repository = repository
    }
    
    func start() {
        let repositoryDetailsViewController = RepositoryDetailsViewController()
        let repositoryDetailsViewModel = RepositoryDetailsViewModel()
        repositoryDetailsViewModel.coordinator = self
        repositoryDetailsViewModel.repository = self.repository
        repositoryDetailsViewController.viewModel = repositoryDetailsViewModel

        navigationController.pushViewController(repositoryDetailsViewController, animated: true)
    }
    
    func didFinish(){
        navigationController.popViewController(animated: true)
    }
    
}
