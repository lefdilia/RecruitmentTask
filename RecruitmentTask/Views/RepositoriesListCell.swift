//
//  RepositoriesListCell.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit


class RepositoriesListCell: UICollectionViewCell {
    
    var repository: RepositoryModel? {
        didSet{
            
            guard let repository = repository else {
                return
            }
            
            ///Owner Image
            ownerPicture.image = UIImage(named: repository.ownerPicture)
            
            ///Repository Title
            repositoryTitleLabel.attributedText = NSAttributedString(string: repository.repositoryName, attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .semibold) ])
            
            ///Stars
            let attributedText = NSMutableAttributedString(string: "")
            let icon = NSTextAttachment()
            icon.image = UIImage(named: "starIcon")?.withTintColor(.warmGrey).withRenderingMode(.alwaysOriginal)
            icon.bounds = CGRect(x: 0, y: -1, width: icon.image!.size.width, height: icon.image!.size.width )
            let attachement = NSAttributedString(attachment: icon)
            attributedText.append(attachement)
            attributedText.append(NSAttributedString(string: " "))
            attributedText.append(NSAttributedString(string: "\(repository.stars)", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .regular), .foregroundColor: UIColor.warmGrey ]))
            repositoryStarsLabel.attributedText = attributedText
        }
    }
    
    static var cellId = "RepositoryCellId"
    
    let ownerPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let repositoryTitleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repositoryStarsLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customAccessory: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.apGray).withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .cellBackground
        layer.cornerRadius = 13
        layer.masksToBounds = true
        
        contentView.addSubview(customAccessory)
        contentView.addSubview(ownerPicture)
        contentView.addSubview(repositoryTitleLabel)
        contentView.addSubview(repositoryStarsLabel)

        
        NSLayoutConstraint.activate([
            ownerPicture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ownerPicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ownerPicture.heightAnchor.constraint(equalToConstant: 60),
            ownerPicture.widthAnchor.constraint(equalToConstant: 60),

            repositoryTitleLabel.topAnchor.constraint(equalTo: ownerPicture.topAnchor, constant: 10),
            repositoryTitleLabel.leadingAnchor.constraint(equalTo: ownerPicture.trailingAnchor, constant: 16),
            repositoryTitleLabel.trailingAnchor.constraint(equalTo: customAccessory.leadingAnchor, constant: 0),

            repositoryStarsLabel.topAnchor.constraint(equalTo: repositoryTitleLabel.bottomAnchor),
            repositoryStarsLabel.leadingAnchor.constraint(equalTo: repositoryTitleLabel.leadingAnchor),
            
            customAccessory.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            customAccessory.centerYAnchor.constraint(equalTo: centerYAnchor),

           
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
