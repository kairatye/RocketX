//
//  LaunchesTableViewCell.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 16.07.2022.
//

import UIKit

class LaunchesTableViewCell: UITableViewCell {
    static let reuseIdentifier = "LaunchesTableViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GlobalMetrics.Colors.collectionViewCellColor
        view.layer.cornerRadius = 24.0
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = GlobalMetrics.Colors.lightTextColor
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.textColor = GlobalMetrics.Colors.unitsTextColor
        return label
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Launch) {
        nameLabel.text = model.name
        
        let date = Date(timeIntervalSince1970: model.dateUnix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, y"
        dateLabel.text = dateFormatter.string(from: date)
        
        switch model.success {
        case true:
            statusImageView.image = UIImage(named: "successIcon")
        case false:
            statusImageView.image = UIImage(named: "failureIcon")
        default:
            statusImageView.image = UIImage(systemName: "null")
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = .black
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(statusImageView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32.0),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24.0),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24.0),
            nameLabel.trailingAnchor.constraint(equalTo: statusImageView.leadingAnchor, constant: -8.0),
            
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24.0),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24.0),
            dateLabel.trailingAnchor.constraint(equalTo: statusImageView.leadingAnchor, constant: -8.0),
            
            statusImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            statusImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32.0),
            statusImageView.heightAnchor.constraint(equalToConstant: 32.0),
            statusImageView.widthAnchor.constraint(equalToConstant: 32.0)
            ])
    }
}
