//
//  ViewController.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 11.07.2022.
//

import UIKit

class RocketInfoViewController: UIViewController {
    
    private var rockets = [Rocket]()
    
    let rocketId: Int
    
    init(rocketId: Int) {
        self.rocketId = rocketId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let rocketInfoView: RocketInfoView = {
        let view = RocketInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.settingsButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
        return view
    }()
    
    private let firstStageView: StageView = {
        let view = StageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let secondStageView: StageView = {
        let view = StageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let launchesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Посмотреть запуски", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
        button.backgroundColor = GlobalMetrics.Colors.collectionViewCellColor
        button.setTitleColor(GlobalMetrics.Colors.basicTextColor, for: .normal)
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(showLaunches), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.addSubview(imageView)
        view.addSubview(rocketInfoView)
        view.addSubview(firstStageView)
        view.addSubview(secondStageView)
        view.addSubview(launchesButton)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        constrain()
        fetch()
    }
    
    private func fetch() {
        URLSession.shared.request(url: Constants.rocketsURL, expecting: [Rocket].self) { result in
            switch result {
            case .success(let rockets):
                DispatchQueue.main.async {
                    self.rockets = rockets
                    self.configureImage()
                    self.configure()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func showLaunches() {
        let launchesViewController = LaunchesViewController(rocketName: rockets[rocketId].name, rocketId: rockets[rocketId].id)

        navigationController?.pushViewController(launchesViewController, animated: true)
    }
    
    @objc private func showSettings() {
        let settingsViewController = SettingsViewController()
        
        present(settingsViewController, animated: true)
    }

    private func setupView() {
        view.addSubview(scrollView)
        rocketInfoView.parametersCollectionView.register(RocketInfoCollectionViewCell.self, forCellWithReuseIdentifier: RocketInfoCollectionViewCell.reuseIdentifier)
        rocketInfoView.parametersCollectionView.dataSource = self
    }
    
    private func configure() {
        rocketInfoView.parametersCollectionView.reloadData()
        rocketInfoView.configureRocketInfo(with: rockets[rocketId])
        firstStageView.configureFirstStage(with: rockets[rocketId])
        secondStageView.configureSecondStage(with: rockets[rocketId])
    }
    
    private func configureImage() {
        DispatchQueue.global().async {
            guard let imageURL = URL(string: self.rockets[self.rocketId].flickrImages.randomElement() ?? "falcon1") else { return }
            if let image = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                }
            }
        }
    }
    
    private func constrain() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 280.0),
            
            rocketInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rocketInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 248.0),
            rocketInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            firstStageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            firstStageView.topAnchor.constraint(equalTo: rocketInfoView.bottomAnchor),
            firstStageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            secondStageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            secondStageView.topAnchor.constraint(equalTo: firstStageView.bottomAnchor),
            secondStageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            secondStageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            launchesButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: GlobalMetrics.horizontalSpacing),
            launchesButton.topAnchor.constraint(equalTo: secondStageView.bottomAnchor),
            launchesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -GlobalMetrics.horizontalSpacing),
            launchesButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            launchesButton.heightAnchor.constraint(equalToConstant: 56.0)
        ])
    }
}

extension RocketInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketInfoCollectionViewCell.reuseIdentifier, for: indexPath) as? RocketInfoCollectionViewCell else {
            fatalError()
        }
        
        cell.configure(with: rockets[rocketId], indexPath: indexPath)
        return cell
    }
}
