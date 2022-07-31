//
//  RocketInfoCollectionViewCell.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 11.07.2022.
//

import UIKit

final class RocketInfoCollectionViewCell: UICollectionViewCell {
    
    private enum ViewMetrics {
        static let horizontalSpacing: CGFloat = 8.0
        static let topVerticalSpacing: CGFloat = 28.0
        static let bottomVerticalSpacing: CGFloat = 24.0
        static let unitLabelHeight: CGFloat = 20.0
    }
    static let reuseIdentifier = "RocketInfoCollectionViewCell"
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        label.textColor = GlobalMetrics.Colors.lightTextColor
        label.textAlignment = .center
        return label
    }()

    var unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.minimumScaleFactor = 0.8
        label.textColor = GlobalMetrics.Colors.unitsTextColor
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = GlobalMetrics.Colors.collectionViewCellColor
        contentView.addSubview(valueLabel)
        contentView.addSubview(unitLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewMetrics.horizontalSpacing),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewMetrics.topVerticalSpacing),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewMetrics.horizontalSpacing),
            valueLabel.bottomAnchor.constraint(equalTo: unitLabel.topAnchor),
            unitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewMetrics.horizontalSpacing),
            unitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewMetrics.horizontalSpacing),
            unitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewMetrics.bottomVerticalSpacing),
            unitLabel.heightAnchor.constraint(equalToConstant: ViewMetrics.unitLabelHeight)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = GlobalMetrics.cornerRadius
        clipsToBounds = true
    }
    
    func configure(with model: Rocket, indexPath: IndexPath) {
        let heightUnit = SettingsStorage.shared.getHeightUnit()
        let diameterUnit = SettingsStorage.shared.getDiameterUnit()
        let massUnit = SettingsStorage.shared.getMassUnit()
        let payloadUnit = SettingsStorage.shared.getPayloadUnit()
        
        let height = heightUnit == "m" ? String(model.height.meters ?? 0.0) : String(model.height.feet ?? 0.0)
        let diameter = diameterUnit == "m" ? String(model.diameter.meters ?? 0.0) : String(model.diameter.feet ?? 0.0)
        let mass = massUnit == "kg" ? String(model.mass.kg) : String(model.mass.lb)
        let payloadWeight = payloadUnit == "kg" ? String(model.payloadWeights[0].kg) : String(model.payloadWeights[0].lb)
        
        switch indexPath.row {
        case 0:
            valueLabel.text = height
            unitLabel.text = "Высота, \(heightUnit)"
        case 1:
            valueLabel.text = diameter
            unitLabel.text = "Диаметр, \(diameterUnit)"
        case 2:
            valueLabel.text = mass
            unitLabel.text = "Масса, \(massUnit)"
        case 3:
            valueLabel.text = payloadWeight
            unitLabel.text = "Нагрузка, \(payloadUnit)"
        default: break
        }
    }
}
