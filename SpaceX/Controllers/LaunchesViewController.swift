//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 16.07.2022.
//

import UIKit

class LaunchesViewController: UIViewController {

    var launches = [Launch]()
    var rocketName: String
    var rocketId: String
    
    init(rocketName: String, rocketId: String) {
        self.rocketName = rocketName
        self.rocketId = rocketId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.contentInset = UIEdgeInsets(top: 32.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.register(LaunchesTableViewCell.self, forCellReuseIdentifier: LaunchesTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        setupView()
        fetch()
    }
    
    private func fetch() {
        URLSession.shared.request(url: Constants.launchesURL, expecting: [Launch].self) { result in
            switch result {
            case .success(let launches):
                DispatchQueue.main.async {
                    self.launches = launches
                        .filter { $0.rocket == self.rocketId }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.backgroundColor = .black
        navigationItem.title = rocketName
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}

extension LaunchesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.reuseIdentifier, for: indexPath) as? LaunchesTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: launches[indexPath.row])

        return cell
    }
}
