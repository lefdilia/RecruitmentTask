//
//  CollectionReusableView.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit


class CollectionReusableView: UICollectionReusableView {

    static let identifier = "headerCollectionView"
    
    let repositoryTitle: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "Repositories", attributes: [
            .font:UIFont.systemFont(ofSize: 22, weight: .bold), .foregroundColor: UIColor.apTintColor])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
                
        addSubview(repositoryTitle)
        NSLayoutConstraint.activate([
            repositoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            repositoryTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
}
