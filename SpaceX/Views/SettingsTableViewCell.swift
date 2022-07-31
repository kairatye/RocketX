//
//  SettingsTableViewCell.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 28.07.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SettingsTableViewCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.textAlignment = .left
        label.textColor = GlobalMetrics.Colors.basicTextColor
        return label
    }()
    
    var unitSwitch: UISegmentedControl = {
        let control = UISegmentedControl(items: ["0", "1"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = GlobalMetrics.Colors.collectionViewCellColor
        control.setTitleTextAttributes([.foregroundColor: GlobalMetrics.Colors.unitsTextColor], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        control.setWidth(56.0, forSegmentAt: 0)
        control.setWidth(56.0, forSegmentAt: 1)
        return control
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [valueLabel, unitSwitch])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            valueLabel.text = "Высота"
            unitSwitch.setTitle("m", forSegmentAt: 0)
            unitSwitch.setTitle("ft", forSegmentAt: 1)
        case 1:
            valueLabel.text = "Диаметр"
            unitSwitch.setTitle("m", forSegmentAt: 0)
            unitSwitch.setTitle("ft", forSegmentAt: 1)
        case 2:
            valueLabel.text = "Масса"
            unitSwitch.setTitle("kg", forSegmentAt: 0)
            unitSwitch.setTitle("lb", forSegmentAt: 1)
        case 3:
            valueLabel.text = "Полезная нагрузка"
            unitSwitch.setTitle("kg", forSegmentAt: 0)
            unitSwitch.setTitle("lb", forSegmentAt: 1)
        default:
            valueLabel.text = ""
            unitSwitch.setTitle("m", forSegmentAt: 0)
            unitSwitch.setTitle("ft", forSegmentAt: 1)
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = .black
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28.0),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            stackView.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}
