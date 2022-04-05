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

    var parentCoordinator: RepositoriesListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let repositoryDetailsViewController = RepositoryDetailsViewController()
        let repositoryDetailsViewModel = RepositoryDetailsViewModel()
        repositoryDetailsViewModel.coordinator = self
        repositoryDetailsViewController.viewModel = repositoryDetailsViewModel
        
        navigationController.setViewControllers([repositoryDetailsViewController], animated: false)

    }

    
    
}
