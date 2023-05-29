//
//  ContentView.swift
//  Weather
//
//  Created by Elise Jang on 5/23/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdate(to location: CLLocation)
}

struct ContentView: View , LocationUpdateProtocol{
    func locationDidUpdate(to location: CLLocation) {
        dLat = location.coordinate.latitude
        dLon = location.coordinate.longitude
        fetchData()
    }
    
    @State var locationName = "San Francisco"
    @State var weatherImg = "01n"
    @State var day = "Wednesday"
    @State var desc = "Sunny"
    @State var temp = "65"
    
    //
    @State var DnN = "d"
    let apikey = "bdf6d535e1951fa36662d87a91680a1f"
    @State var dLat = 33.640495
    @State var dLon = -117.844296
    var actIndicator : NVActivityIndicatorView!
    @State var userLocation: CLLocation?
    var locationManagerclass = LocationManager()
    

    
    
    @State private var isLoading = true
    
    
    var body: some View {
        
        VStack {
            if isLoading {
                ProgressView()
            } else {
                ZStack { //stacks along Z axis
                        if DnN == "d"{
                            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()

                        }
                        else{
                            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()
                        }
                    
                    VStack {
                        Text(locationName)
                            .font(.largeTitle)
                        
                            .foregroundColor(.white)
                        
                        Text(day)
                            .font(.title2)
                            .foregroundColor(Color.white)
                        Image(weatherImg)
                            .resizable()
                            .frame(width: 300, height: 300)
                        Text(desc)
                            .font(.title2)
                            .foregroundColor(Color.white)
                        Text(temp)
                            .font(.system(size: 100))
                            .foregroundColor(Color.white)
                        +
                        Text("\u{2103}")
                            .font(.system(size: 50))
                            .baselineOffset(30.0)
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    }
                    .padding()
                    
                }
            }
        }
        .onAppear{
            fetchData()
            
        }
    }
    
    func locationManager(_ userLocation: CLLocation?) {

        self.dLat = locationManagerclass.userLocation?.coordinate.latitude ?? 33.640495
        self.dLon = locationManagerclass.userLocation?.coordinate.longitude ?? 117.844296
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(dLat)&lon=\(dLon)&appid=\(apikey)&units=metric").responseJSON {response in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                
                self.locationName = jsonResponse["name"].stringValue
                self.weatherImg = iconName
                self.desc = jsonWeather["main"].stringValue
                self.temp = "\(Int(round(jsonTemp["temp"].doubleValue)))"
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                self.day = dateFormatter.string(from: date)
                
                let suffix = iconName.suffix(1)
                if(suffix == "n"){
                    self.DnN = "n"
                }else{
                    self.DnN = "d"
                }
            }
        }
    }
    
    
    
    func fetchData() {
        isLoading = true
        
        locationManagerclass.delegate = self
        locationManagerclass.startUpdatingLocation()
        locationManager(userLocation)
        isLoading = false
        
        }
    

    class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
        private let locationManager = CLLocationManager()
        @Published var userLocation: CLLocation?
        var delegate: LocationUpdateProtocol?

        override init() {
            super.init()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }

        func startUpdatingLocation() {
            locationManager.startUpdatingLocation()
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                userLocation = location
                delegate?.locationDidUpdate(to: location)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
