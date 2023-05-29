//
//  WeatherApp.swift
//  Weather
//
//  Created by Elise Jang on 5/23/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

@main
struct WeatherApp: App{
//    let apikey = "bdf6d535e1951fa36662d87a91680a1f"
//    var dLat = 33.6424
//    var dLon = 117.8417
//    var actIndicator : NVActivityIndicatorView!
//    let locManager = CLLocationManager()
//    let locManagerDelegate = LocationManagerDelegate()
//
//    init() {
//        GeometryReader { geometry in
//            let indicatorSize: CGFloat = 70
//            let indicatorFrame = CGRect(x: (geometry.size.width-indicatorSize)/2, y: (geometry.size.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
//            actIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
//            actIndicator.backgroundColor = UIColor.black
//            view.addSubview(actIndicator)
//
//
//
//            actIndicator.startAnimating()
//            locManager.requestWhenInUseAuthorization()
//
//            if (CLLocationManager.locationServicesEnabled()){
//                locManager.delegate = locManagerDelegate
//                locManager.desiredAccuracy = kCLLocationAccuracyBest
//                locManager.startUpdatingLocation()
//            }
//        }
//        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
