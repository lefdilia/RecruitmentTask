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
    var repositories: [Repositories] = []
    
    //SearchRelated
    var page = 1
    var moreRepos = true

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.backgroundColor = .apTintColor.withAlphaComponent(0.4)
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.layer.cornerRadius = 8
        activityIndicator.widthAnchor.constraint(equalToConstant: 80).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 80).isActive = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - Setup Views
    
    ///Search Bar
    let searchController = UISearchController(searchResultsController: nil)
    
    /// Top Header (CollectionView)
    lazy var repositoriesListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .apBackground
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
        
        view.backgroundColor = .apBackground
                
        /// Styling searchController && SearchBar
        searchController.searchBar.placeholder = "Search Repositories..."
        searchController.searchBar.searchTextField.backgroundColor = .clear
        searchController.searchBar.tintColor = .apTintColor
        searchController.searchBar.delegate = self
        ///
        navigationItem.searchController = searchController
        navigationItem.title = viewModel.title
        navigationItem.titleView?.tintColor = .apTintColor
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(repositoriesListView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            repositoriesListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            repositoriesListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            repositoriesListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            repositoriesListView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
        ])
        
        viewModel.onUpdate = { [weak self] in
            guard let repositories = self?.viewModel.repositories else {
                return
            }
            
            if repositories.count < 100 {
               self?.moreRepos = false
            }
            
            let _page = self?.page ?? 1
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                                
                if _page > 1 {
                    self?.repositories.append(contentsOf: repositories)
                }else{
                    self?.repositories = repositories
                }
                
                self?.repositoriesListView.reloadData()
            }
        }
    }
}


extension RepositoriesListViewController: UISearchBarDelegate {
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTimer?.invalidate()
        
        if searchText.isEmpty {
            self.activityIndicator.stopAnimating()
            return
        }
            
        searchBarTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.activityIndicator.startAnimating()
            self?.viewModel.fetchRepositories(keyword: searchText)
        })
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let repository = repositories[indexPath.item]
        viewModel.didSelectRepository(repository)
        
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard  let searchText = searchController.searchBar.text, moreRepos == true else { return }
            page += 1
            self.activityIndicator.startAnimating()
            self.viewModel.fetchRepositories(keyword: searchText, page: page)
        }
    }

}
