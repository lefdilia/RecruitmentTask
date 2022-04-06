//
//  CommitsHistoryListCell.swift
//  RecruitmentTask
//
//  Created by Lefdili Alaoui Ayoub on 5/4/2022.
//

import UIKit


class CommitsHistoryListCell: UITableViewCell {
    
    static var cellId = "CommitsHistoryCellId"
        
    override var tag: Int {
        didSet{
            
            indexLabel.attributedText = NSAttributedString(string: "\(tag+1)",
                             attributes: [
                                .font: UIFont.systemFont(ofSize: 17, weight: .medium),
                                .foregroundColor: UIColor.black
                             ])
        }
    }
    
    var commitHistory: CommitsHistory? {
        didSet{
            
            guard let commitHistory = commitHistory else { return }
            
            let author = commitHistory.commit.author
            
            commitAuthorLabel.attributedText = NSAttributedString(string: author.name,
                                 attributes: [
                                    .font: UIFont.systemFont(ofSize: 11, weight: .semibold),
                                    .foregroundColor: UIColor.blueAzure
                                 ])
            
            commitEmailLabel.attributedText = NSAttributedString(string: author.email,
                                 attributes: [
                                    .font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                    .foregroundColor: UIColor.apTintColor
                                 ])
            commitMessageLabel.attributedText = NSAttributedString(string: commitHistory.commit.message,
                                 attributes: [
                                    .font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                    .foregroundColor: UIColor.warmGrey
                                 ])

        }
    }
    
    let indexLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        label.backgroundColor = .cellBackground
        label.layer.cornerRadius = 18
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    let commitAuthorLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commitEmailLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commitMessageLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var _viewSep: UIView = {
        let _view = UIView()
        _view.backgroundColor = .clear
        _view.translatesAutoresizingMaskIntoConstraints = false
        return _view
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(indexLabel)
        contentView.addSubview(commitAuthorLabel)
        contentView.addSubview(commitEmailLabel)
        contentView.addSubview(commitMessageLabel)
        contentView.addSubview(_viewSep)

        NSLayoutConstraint.activate([
            
            indexLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            indexLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            indexLabel.heightAnchor.constraint(equalToConstant: 36),
            indexLabel.widthAnchor.constraint(equalToConstant: 36),

            commitAuthorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            commitAuthorLabel.leadingAnchor.constraint(equalTo: indexLabel.trailingAnchor, constant: 20),

            commitEmailLabel.topAnchor.constraint(equalTo: commitAuthorLabel.bottomAnchor, constant: 2),
            commitEmailLabel.leadingAnchor.constraint(equalTo: commitAuthorLabel.leadingAnchor),
            commitEmailLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),

            commitMessageLabel.topAnchor.constraint(equalTo: commitEmailLabel.bottomAnchor, constant: 2),
            commitMessageLabel.leadingAnchor.constraint(equalTo: commitAuthorLabel.leadingAnchor),
            commitMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commitMessageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

            _viewSep.topAnchor.constraint(equalTo: commitMessageLabel.bottomAnchor, constant: 0),
            _viewSep.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            _viewSep.trailingAnchor.constraint(equalTo: commitMessageLabel.trailingAnchor, constant: 0),
            _viewSep.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            _viewSep.heightAnchor.constraint(equalToConstant: 10),

        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


