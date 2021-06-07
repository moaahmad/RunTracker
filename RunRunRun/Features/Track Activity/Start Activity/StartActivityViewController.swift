//
//  StartActivityViewController.swift
//  RunRunRun
//
//  Created by Mohammed Ahmad on 6/27/20.
//  Copyright © 2020 Mohammed Ahmad. All rights reserved.
// 

import UIKit
import MapKit

final class StartActivityViewController: BaseViewController {
    private struct Constants {
        static let latitudinalMeters = 1000.0
        static let longitudinalMeters = 1000.0
        private init() {}
    }

    // MARK: - Properties

    var viewModel: StartActivityViewModeling

    private lazy var mapView = MKMapView()
    private lazy var locationButton = RMLocationButton()
    private lazy var startButton = RMActionButton(title: "START")

    // MARK: - Initializers

    init(viewModel: StartActivityViewModeling = StartActivityViewModel()) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.checkLocationAuthStatus()
        statusBarEnterDarkBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerMapOnUserLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.stopUpdatingLocation()
    }

    private func setupBindings() {
        viewModel.didChangeAuthorization = { [weak self] in
            self?.mapView.showsUserLocation = true
        }
    }
}

// MARK: - Center Map

private extension StartActivityViewController {
    func centerMapOnUserLocation() {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsScale = true

        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate,
                                                  latitudinalMeters: Constants.latitudinalMeters,
                                                  longitudinalMeters: Constants.longitudinalMeters)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - Button Actions

extension StartActivityViewController {
    @objc private func didTapLocateUserButton() {
        centerMapOnUserLocation()
        UISelectionFeedbackGenerator().selectionChanged()
    }

    @objc private func didTapStartRunButton() {
        viewModel.startRunDidTap()
    }
}

// MARK: - Layout Configuration

private extension StartActivityViewController {
    func setupLayout() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemBackground

        configureMapView()
        configureStartButton()
        configureLocationButton()
    }
    
    func configureMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureStartButton() {
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(didTapStartRunButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 120),
            startButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configureLocationButton() {
        locationButton.adjustsImageWhenHighlighted = false
        view.addSubview(locationButton)
        locationButton.addTarget(self, action: #selector(didTapLocateUserButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            locationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -8),
            locationButton.bottomAnchor.constraint(equalTo: startButton.bottomAnchor, constant: -4),
            locationButton.heightAnchor.constraint(equalToConstant: 45),
            locationButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
