//
//  LocationDetailViewController.swift
//  weatherGift
//
//  Created by Marissa Spletter on 10/10/21.
//

import UIKit

class LocationDetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherLocation: WeatherLocation!
    var weatherLocations: [WeatherLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if weatherLocation == nil {
            weatherLocation = WeatherLocation(name: "Current Location", latitude: 0.0, longitude: 0.0)
            weatherLocations.append(weatherLocation)
        }
        loadLocations()
        updateUserInterface()
    }
    
    func loadLocations() {
        guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations") as? Data else {
            print("Could not load weatherLocations...")
            return
        }
        let decoder = JSONDecoder()
        if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as
            [WeatherLocation] {
            self.weatherLocations = weatherLocation
        } else {
            print("ERROR: Couldnt decode data read from UserDefauls")
        }
        
    }
    
    func updateUserInterface() {
        dateLabel.text = ""
        placeLabel.text = weatherLocation.name
        temperatureLabel.text = ""
        summaryLabel.text = ""  }
//        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
//        let weatherLocation = pageViewController.weatherLocations[locationIndex]
//        weatherDetail = WeatherDetail(name: weatherLocation.name, latitude: weatherLocation.latitude, longitude: weatherLocation.longitude)
//
//        pageControl.numberOfPages = pageViewController.weatherLocations.count
//        pageControl.currentPage = locationIndex
//
//        weatherDetail.getData {
//            DispatchQueue.main.async {
//                dateFormatter.timeZone = TimeZone(identifier: self.weatherDetail.timezone)
//                let usableDate = Date(timeIntervalSince1970: self.weatherDetail.currentTime)
//                self.dateLabel.text = dateFormatter.string(from: usableDate)
//                self.placeLabel.text = self.weatherDetail.name
//                self.temperatureLabel.text = "\(self.weatherDetail.temperature)°"
//                self.summaryLabel.text = self.weatherDetail.summary
//                self.imageView.image = UIImage(named: self.weatherDetail.dayIcon)
//                self.tableView.reloadData()
//                self.collectionView.reloadData()
//        }
//    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "ShowList" {
//                let destination = segue.destination as! LocationListViewController
//                let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
//                destination.weatherLocations = pageViewController.weatherLocations
                let destination = segue.destination as! LocationListViewController
                destination.weatherLocations = weatherLocations

        }
        
        @IBAction func unwindFromLocationListViewController(segue: UIStoryboardSegue) {
            let source = segue.source as! LocationListViewController
            weatherLocations = source.weatherLocations
            weatherLocation = weatherLocations[source.selectedLocationIndex]
            updateUserInterface()
//            locationIndex = source.selectedLocationIndex
//
//            let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
//            pageViewController.weatherLocations = source.weatherLocations
//            pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: locationIndex)], direction: .forward, animated: false, completion: nil)
        }

}
