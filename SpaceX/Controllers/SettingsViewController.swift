//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 29.07.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize)
        label.text = "Настройки"
        label.textColor = GlobalMetrics.Colors.lightTextColor
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Закрыть", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: GlobalMetrics.fontSize, weight: .bold)
        button.backgroundColor = .black
        button.setTitleColor(GlobalMetrics.Colors.lightTextColor, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func setupView() {
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 18.0),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -GlobalMetrics.verticalSpacing),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: GlobalMetrics.verticalSpacing),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            fatalError()
        }
        cell.configure(indexPath: indexPath)
        cell.unitSwitch.addTarget(self, action: #selector(unitChanged(_:)), for: .valueChanged)
        cell.unitSwitch.tag = indexPath.row
        return cell
    }
    
    @objc private func unitChanged(_ segmentedControl: UISegmentedControl) {
        let titleForSelectedSegmentIndex = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? ""
        switch segmentedControl.tag {
        case 0:
            SettingsStorage.shared.setHeightUnit(titleForSelectedSegmentIndex)
        case 1:
            SettingsStorage.shared.setDiameterUnit(titleForSelectedSegmentIndex)
        case 2:
            SettingsStorage.shared.setMassUnit(titleForSelectedSegmentIndex)
        case 3:
            SettingsStorage.shared.setPayloadUnit(titleForSelectedSegmentIndex)
        default:
            break
        }
    }
}

