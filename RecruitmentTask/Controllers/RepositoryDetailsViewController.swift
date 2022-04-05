//
//  RepositoryDetailsViewController.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit


class RepositoryDetailsViewController: UIViewController {
    
    var viewModel: RepositoryDetailsViewModel!
    
    var commits: [CommitsModel] = [
        CommitsModel(authorName: "lefdilia", email: "lefdilia@gmail.com", message: "This is a commit message that needs to fold over to the next line."),
        CommitsModel(authorName: "lefdilia", email: "lefdilia@gmail.com", message: "This is a commit message that needs to fold over to the next line."),
        CommitsModel(authorName: "lefdilia", email: "lefdilia@gmail.com", message: "This is a commit message that needs to fold over to the next line."),
    ]
    
    var repository: RepositoryModel?

    let topContainer: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let smallTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "REPO BY", attributes: [
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold),
            .foregroundColor: UIColor.white.withAlphaComponent(0.6)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "Repo Author Name", attributes: [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .foregroundColor: UIColor.white
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    lazy var CommitsHistoryList: UITableView = {
        let table = UITableView()
        table.register(CommitsHistoryListCell.self, forCellReuseIdentifier: CommitsHistoryListCell.cellId)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .apBackground
        table.separatorStyle = .singleLine
        table.separatorInset = .zero
        table.layoutMargins = .zero
        
        return table
    }()
    
    
    //MARK: - FooterView
    let footerView: UIView = {
        let _view = UIView()
        return _view
    }()
    
    lazy var shareRepoButton: UIButton = { [weak self] in
        let button = UIButton(type: .custom)
        
        let title = "Share Repo"

        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .buttonColor
        configuration.baseForegroundColor = .blueAzure
        configuration.cornerStyle = .medium
        configuration.buttonSize = .large
        
        configuration.image = UIImage(named: "shareIcon")?.withRenderingMode(.alwaysOriginal)
        configuration.imagePadding = 9

        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        configuration.attributedTitle = AttributedString("\(title)", attributes: container)
        

        button.configuration = configuration

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.addTarget(self, action: #selector(self?.didTapviewShareRepoButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        ///
        let attributedText = NSMutableAttributedString(string: "")
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "starIcon")?.withTintColor(.warmGrey).withRenderingMode(.alwaysOriginal)
        icon.bounds = CGRect(x: 0, y: -1, width: icon.image!.size.width, height: icon.image!.size.width )
        let attachement = NSAttributedString(attachment: icon)
        attributedText.append(attachement)
        attributedText.append(NSAttributedString(string: " "))
        attributedText.append(NSAttributedString(string: "Number of Stars (234)", attributes: [
            .font: UIFont.systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: UIColor.white ]))
        starsLabel.attributedText = attributedText
        ///
        DispatchQueue.main.async {
            self.topImageView.image = UIImage(named: "gravatar-user-420")
        }

        //MARK: - Table Footer View
        CommitsHistoryList.tableFooterView = footerView
        CommitsHistoryList.tableFooterView?.frame.size.height = 70
        
        footerView.addSubview(shareRepoButton)
        
        NSLayoutConstraint.activate([
            shareRepoButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            shareRepoButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            shareRepoButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
        ])
        
        CommitsHistoryList.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .apBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", image: UIImage(systemName: "chevron.backward")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), primaryAction: .none, menu: .none)
        
        view.addSubview(topContainer)
        topContainer.addSubview(topImageView)
        topContainer.addSubview(smallTitleLabel)
        topContainer.addSubview(ownerNameLabel)
        topContainer.addSubview(starsLabel)
        
        view.addSubview(CommitsHistoryList)

        NSLayoutConstraint.activate([
            
            topContainer.topAnchor.constraint(equalTo: view.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32),
            
            topImageView.topAnchor.constraint(equalTo: topContainer.topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor),
            topImageView.heightAnchor.constraint(equalTo: topContainer.heightAnchor),

            smallTitleLabel.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 20),
            smallTitleLabel.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -20),
            smallTitleLabel.bottomAnchor.constraint(equalTo: ownerNameLabel.topAnchor, constant: -4),

            ownerNameLabel.leadingAnchor.constraint(equalTo: smallTitleLabel.leadingAnchor),
            ownerNameLabel.trailingAnchor.constraint(equalTo: smallTitleLabel.trailingAnchor),
            ownerNameLabel.bottomAnchor.constraint(equalTo: starsLabel.topAnchor, constant: -6),

            starsLabel.leadingAnchor.constraint(equalTo: ownerNameLabel.leadingAnchor),
            starsLabel.trailingAnchor.constraint(equalTo: ownerNameLabel.trailingAnchor),
            starsLabel.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -22),

            CommitsHistoryList.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            CommitsHistoryList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            CommitsHistoryList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            CommitsHistoryList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
        
    }
}

extension RepositoryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView: UIView = {
            let _view = UIView()
            _view.backgroundColor = .apBackground
            return _view
        }()
        
        let headerLabel: UILabel = {
            let label = UILabel()
            let attributedText = NSMutableAttributedString(string: "Repo Title", attributes: [
                .font : UIFont.systemFont(ofSize: 17, weight: .semibold),
                .foregroundColor : UIColor.apTintColor ])
            label.attributedText = attributedText
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let topTitleLabel: UILabel = {
            let label = UILabel()
            let attributedText = NSMutableAttributedString(string: "Commits History", attributes: [
                .font : UIFont.systemFont(ofSize: 22, weight: .bold),
                .foregroundColor : UIColor.apTintColor ])
            label.attributedText = attributedText
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let viewOnlineButton: UIButton = {
            let button = UIButton(type: .custom)

            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = .buttonColor
            configuration.baseForegroundColor = .blueAzure
            configuration.cornerStyle = .capsule
            
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            configuration.attributedTitle = AttributedString("VIEW ONLINE", attributes: container)
            
            button.configuration = configuration
            button.addTarget(self, action: #selector(didTapviewOnlineButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        
        lazy var stackButtons: UIStackView = {
           let stack = UIStackView(arrangedSubviews: [headerLabel, viewOnlineButton])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.distribution = .equalSpacing
            return stack
        }()
        
        
        headerView.addSubview(stackButtons)
        headerView.addSubview(topTitleLabel)

        NSLayoutConstraint.activate([
            stackButtons.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            stackButtons.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            stackButtons.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            topTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            topTitleLabel.leadingAnchor.constraint(equalTo: stackButtons.leadingAnchor),
        ])
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitsHistoryListCell.cellId, for: indexPath) as! CommitsHistoryListCell
        
        cell.commit = commits[indexPath.row]

        if indexPath.row == commits.count-1 {
            cell.separatorInset.right = cell.bounds.size.width
        }
        
        cell.tag = indexPath.row
        return cell
    }
    
    
    //MARK: - Checkout
    
    @objc func didTapviewOnlineButton(){
        print("Tapped viewOnlineButton..")
    }
    
    @objc func didTapviewShareRepoButton(){
        print("Tapped ShareRepoButton..")
    }
    
    @objc func didTapBackButton(){
        print("Tap Back Button")
    }
    

}
