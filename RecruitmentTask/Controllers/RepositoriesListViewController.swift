//
//  RepositoriesListViewController.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit


class RepositoriesListViewController: UIViewController {
    
    var searchBarTimer: Timer?
    var viewModel: RepositoriesListViewModel!
    
    var repositories: [RepositoryModel] = [
        RepositoryModel(repositoryName: "Repo Title", ownerPicture: "gravatar-user-420", stars: 997),
        RepositoryModel(repositoryName: "Axabot", ownerPicture: "gravatar-user-420", stars: 100),
        RepositoryModel(repositoryName: "ImageSnapper", ownerPicture: "gravatar-user-420", stars: 230),
        RepositoryModel(repositoryName: "Tetris", ownerPicture: "gravatar-user-420", stars: 230),
        RepositoryModel(repositoryName: "Axabot", ownerPicture: "gravatar-user-420", stars: 100),
        RepositoryModel(repositoryName: "ImageSnapper", ownerPicture: "gravatar-user-420", stars: 230),
        RepositoryModel(repositoryName: "ImageSnapper", ownerPicture: "gravatar-user-420", stars: 230),
        RepositoryModel(repositoryName: "Tetris", ownerPicture: "gravatar-user-420", stars: 230),
        RepositoryModel(repositoryName: "Axabot", ownerPicture: "gravatar-user-420", stars: 100),
        RepositoryModel(repositoryName: "ImageSnapper", ownerPicture: "gravatar-user-420", stars: 230),
    ]
    
    //MARK: - Setup Views
    
    ///Search Bar
    let searchController = UISearchController(searchResultsController: nil)
    
    /// Top Header (CollectionView)
    lazy var repositoriesListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(RepositoriesListCell.self, forCellWithReuseIdentifier: RepositoriesListCell.cellId)
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        /// Styling searchController && SearchBar
        searchController.searchBar.placeholder = "Search Repositories..."
        searchController.searchBar.searchTextField.backgroundColor = .clear
        searchController.searchBar.delegate = self

        ///
        navigationItem.searchController = searchController
        navigationItem.title = viewModel.title
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true

        
        view.addSubview(repositoriesListView)
        NSLayoutConstraint.activate([
            repositoriesListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            repositoriesListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            repositoriesListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            repositoriesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
}


extension RepositoriesListViewController: UISearchBarDelegate {
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTimer?.invalidate()
        searchBarTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
          
            //Make requets to API
            
            print("searchText ", searchText)
            
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //Clear Collection View
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
    }
    
}


extension RepositoriesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 30 , height: 92)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.identifier, for: indexPath) as! CollectionReusableView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepositoriesListCell.cellId, for: indexPath) as! RepositoriesListCell
        
        let repository = repositories[indexPath.item]
        cell.repository = repository
        return cell
    }
    
    
}
