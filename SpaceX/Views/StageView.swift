//
//  StageView.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 12.07.2022.
//

import UIKit

class StageView: UIView {
    
    private enum ViewMetrics {
        static let horizontalSpacing: CGFloat = 8.0
        static let verticalSpacing: CGFloat = 16.0
    }
    let stageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .left
        return label
    }()
    
    let enginesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.text = "Количество двигателей"
        label.textColor = GlobalMetrics.Colors.basicColor
        label.textAlignment = .left
        return label
    }()
    
    let fuelAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.text = "Количество топлива"
        label.textColor = GlobalMetrics.Colors.basicColor
        label.textAlignment = .left
        return label
    }()
    
    let burnTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.text = "Время сгорания"
        label.textColor = GlobalMetrics.Colors.basicColor
        label.textAlignment = .left
        return label
    }()
    
    let enginesCountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .left
        return label
    }()
    
    let fuelAmountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .left
        return label
    }()
    
    let burnTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        label.textColor = GlobalMetrics.Colors.basicTextColor
        label.textAlignment = .left
        return label
    }()
    
    let fuelAmountUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        label.text = "ton"
        label.textColor = GlobalMetrics.Colors.unitsTextColor
        label.textAlignment = .right
        return label
    }()
    
    let burnTimeUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        label.text = "sec"
        label.textColor = GlobalMetrics.Colors.unitsTextColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var fuelAmountUnitStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fuelAmountValueLabel, fuelAmountUnitLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = ViewMetrics.horizontalSpacing
        return stackView
    }()

    private lazy var burnTimeUnitStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [burnTimeValueLabel, burnTimeUnitLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = ViewMetrics.horizontalSpacing
        return stackView
    }()

    private lazy var enginesCountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [enginesCountLabel, enginesCountValueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var fuelAmountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fuelAmountLabel, fuelAmountUnitStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var burnTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [burnTimeLabel, burnTimeUnitStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stageLabel, enginesCountStackView, fuelAmountStackView, burnTimeStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = ViewMetrics.verticalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureFirstStage(with model: Rocket) {
        stageLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        enginesCountValueLabel.text = String(model.firstStage.engines)
        fuelAmountValueLabel.text = String(model.firstStage.fuelAmountTons)
        burnTimeValueLabel.text = String(model.firstStage.burnTimeSEC ?? 0)
    }
    
    func configureSecondStage(with model: Rocket) {
        stageLabel.text = "ВТОРАЯ СТУПЕНЬ"
        enginesCountValueLabel.text = String(model.secondStage.engines)
        fuelAmountValueLabel.text = String(model.secondStage.fuelAmountTons)
        burnTimeValueLabel.text = String(model.secondStage.burnTimeSEC ?? 0)
    }
    
    private func setupView() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalMetrics.horizontalSpacing),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GlobalMetrics.horizontalSpacing),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -GlobalMetrics.verticalSpacing)
        ])
    }
}
