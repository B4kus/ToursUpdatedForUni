//
//  DetailViewController.swift
//  Tours
//
//  Created by Szymon Szysz on 27.06.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class DetailViewController: GenericViewController, ViewConfigurable {
    
    //MARK: - Views
    
    typealias ContentViewType = DetailView
    
    //MARK: - Managers
    
    private let firebaseDatabaseManager: FirebaseDatabaseManaging
    private let locationManager = CLLocationManager()
    
    //MARK: - Properties
    private let tourID: String
    private var tourDetails: TourDetails? {
        didSet { tourDetailsHandle() }
    }
    //TO DO set center of tour
    
    let initialLocation = CLLocation(latitude: 50.263547, longitude: 19.035196)
    let regionRadius: CLLocationDistance = 2000
    
    init(tourID: String,
         firebaseDatabaseManager: FirebaseDatabaseManaging = FirebaseDatabaseManager()) {
        self.tourID = tourID
        self.firebaseDatabaseManager = firebaseDatabaseManager
        super.init()
    }
    
    required init?(coder: NSCoder) { assertionFailure(); return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        centerMapOnLocation(location: initialLocation)
        downloadTourDetails()
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        contentView.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func loadView() {
        super.loadView()
        loadContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = systemBlueColor
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationItem.leftBarButtonItem?.tintColor = systemBlueColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hideTransparentNavigationBar()
    }
    
    @objc func openMapApp() {
        guard let tourDetails = tourDetails else { return }
        let listOfArtWorks = tourDetails.coordinatesList.map { Artwork(model: $0) }
        guard let firstArtPoint = listOfArtWorks.first else { return }
        openMapForPlace(lat: firstArtPoint.coordinate.latitude, long: firstArtPoint.coordinate.longitude, placeName: firstArtPoint.locationName)
    }
    
    private func setupDelegate() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        contentView.mapView.delegate = self
        stopMonitoring()
        contentView.startButton.addTarget(self, action: #selector(openMapApp), for: .touchUpInside)
    }
    
    private  func saveAllGeotifications() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(tourDetails?.coordinatesList)
            UserDefaults.standard.set(data, forKey: PreferencesKeys.savedItems)
        } catch {
            print("error encoding geotifications")
        }
    }
    
    private func createPolygon(listOfArtWorks: [MKAnnotation] ) {
        let points: [CLLocationCoordinate2D] = listOfArtWorks.map { $0.coordinate }
        let polygon = MKPolygon(coordinates: points, count: points.count)
        contentView.mapView.addOverlay(polygon)
    }
    
    private func tourDetailsHandle() {
        guard let tourDetails = tourDetails else { return }
        let listOfArtWorks = tourDetails.coordinatesList.map { Artwork(model: $0) }
        guard let firstArtPoint = listOfArtWorks.first else { return }
        let initialLocation = CLLocation(latitude: firstArtPoint.coordinate.latitude, longitude: firstArtPoint.coordinate.longitude)
        centerMapOnLocation(location: initialLocation)
        contentView.mapView.addAnnotations(listOfArtWorks)
        createPolygon(listOfArtWorks: listOfArtWorks)
        listOfArtWorks.forEach {
            startMonitoring(geotification: $0)
        }        
    }
    
    private func region(with geotification: Artwork) -> CLCircularRegion {
        let region = CLCircularRegion(center: geotification.coordinate, radius: geotification.radius, identifier: geotification.identifier)
        region.notifyOnEntry = (geotification.eventType == .onEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    private func startMonitoring(geotification: Artwork) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            return
        }
        
        let fenceRegion = region(with: geotification)
        locationManager.startMonitoring(for: fenceRegion)
    }
    
    private func stopMonitoring() {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion else { return }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
}

extension DetailViewController {
    
    private func downloadTourDetails() {
        startActivityIndicator()
        firebaseDatabaseManager.getTourDetails(tourId: tourID) { [weak self] result in
            guard let self = self else { return }
            self.tourDetails = result
            self.stopActivityIndicator()
        }
    }
}

extension DetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard overlay is MKPolygon else { return MKOverlayRenderer() }
        let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.strokeColor = systemBlueColor
        polygonView.lineWidth = 2
        return polygonView
    }
}

extension DetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        contentView.mapView.showsUserLocation = status == .authorizedAlways
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
}

extension DetailViewController {
    
    func openMapForPlace(lat:Double = 0, long:Double = 0, placeName:String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
    
}
