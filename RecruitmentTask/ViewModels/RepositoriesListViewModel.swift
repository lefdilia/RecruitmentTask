//
//  RepositoriesListViewModel.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import Foundation

final class RepositoriesListViewModel {
    
    var coordinator: RepositoriesListCoordinator?
    let title = "--"

    
    func didSelectRepository(){
        coordinator?.selectRepository()
    }

}
