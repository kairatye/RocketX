//
//  RocketInfoView.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 12.07.2022.
//

import UIKit

class RocketInfoView: UIView {
    
    private enum ViewMetrics {
        static let verticalSpacing: CGFloat = 16.0
    }
    
    let rocketName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.text = "Falcon Heavy"
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .left
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.tintColor = GlobalMetrics.Colors.basicColor
        return button
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rocketName, settingsButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var parametersCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12.0
        flowLayout.itemSize = CGSize(width: 96.0, height: 96.0)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 0.0, left: 32.0, bottom: 0.0, right: 32.0)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let firstFlightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.text = "Первый запуск"
        label.textColor = GlobalMetrics.Colors.basicColor
        label.textAlignment = .left
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.text = "Страна"
        label.textColor = GlobalMetrics.Colors.basicColor
        label.textAlignment = .left
        return label
    }()
    
    let launchCostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.text = "Стоимость запуска"
        label.textColor = GlobalMetrics.Colors.basicColor
        label.textAlignment = .left
        return label
    }()
    
    let firstFlightValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .right
        return label
    }()
    
    let countryValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .right
        return label
    }()
    
    let launchCostValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var firstFlightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstFlightLabel, firstFlightValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryLabel, countryValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var launchCostStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [launchCostLabel, launchCostValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: GlobalMetrics.cornerRadius)
    }
    
    func configureRocketInfo(with model: Rocket) {
        rocketName.text = model.name
        firstFlightValueLabel.text = model.firstFlight
        countryValueLabel.text = model.country
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US")
        let launchCost = numberFormatter.string(from: NSNumber(value: model.costPerLaunch / 1000000))
        if let launchCost = launchCost {
            launchCostValueLabel.text = "\(launchCost) млн"
        }
    }
    
    private func setupView() {
        addSubview(headerStackView)
        addSubview(parametersCollectionView)
        addSubview(firstFlightStackView)
        addSubview(countryStackView)
        addSubview(launchCostStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalMetrics.horizontalSpacing),
            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 48.0),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GlobalMetrics.horizontalSpacing),
            
            parametersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            parametersCollectionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 32.0),
            parametersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            parametersCollectionView.heightAnchor.constraint(equalToConstant: 96.0),
            
            firstFlightStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalMetrics.horizontalSpacing),
            firstFlightStackView.topAnchor.constraint(equalTo: parametersCollectionView.bottomAnchor, constant: GlobalMetrics.verticalSpacing),
            firstFlightStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GlobalMetrics.horizontalSpacing),
            
            countryStackView.topAnchor.constraint(equalTo: firstFlightStackView.bottomAnchor, constant: ViewMetrics.verticalSpacing),
            countryStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalMetrics.horizontalSpacing),
            countryStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GlobalMetrics.horizontalSpacing),
            
            launchCostStackView.topAnchor.constraint(equalTo: countryStackView.bottomAnchor, constant: ViewMetrics.verticalSpacing),
            launchCostStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalMetrics.horizontalSpacing),
            launchCostStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GlobalMetrics.horizontalSpacing),
            launchCostLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -GlobalMetrics.verticalSpacing)
        ])
    }
}
