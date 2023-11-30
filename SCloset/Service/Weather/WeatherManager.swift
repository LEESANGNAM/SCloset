//
//  WeatherManager.swift
//  SCloset
//
//  Created by 이상남 on 12/1/23.
//

import WeatherKit
import CoreLocation

class WeatherManager: NSObject {
    static let shared = WeatherManager()
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var currentWeather: TodayWeatherModel?
    private var locationName = ""
    
    private override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func updateWeather() {
        locationManager.startUpdatingLocation()
    }
    func getTodayWeather() -> TodayWeatherModel? {
        return currentWeather
    }
    
    private func fetchCurrentWeather() {
        guard let location = currentLocation else {
            return
        }
        Task {
            do {
                let result = try await WeatherService().weather(for: location)
                guard let weather = result.dailyForecast.forecast.first else { return }
                let date = weather.date.yyyyMMddFormattedDateString()
                let highTemperature = weather.highTemperature
                let lowTemperature = weather.lowTemperature
                let symbol = weather.symbolName
                
                
                let todayWeather = TodayWeatherModel(date: date, location: locationName, highTemperature: highTemperature, lowTemperature: lowTemperature, symbolName: symbol)
                print("오늘의 날씨 : ",todayWeather)
                currentWeather = todayWeather
            } catch {
                print("날씨 정보 업데이트 실패: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchAddressName() {
        guard let location = currentLocation else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error {
                print("Geocoding 실패: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                self.locationName = self.getAddressName(placemark: placemark)
            } else {
                print("placemarks 실패")
            }
        }
    }
    private func getAddressName(placemark: CLPlacemark) -> String {
        var result = ""
        guard let administrativeArea = placemark.administrativeArea,
              let locality = placemark.locality,
              let subLocality = placemark.subLocality else { return "" }
        
        if administrativeArea == "서울특별시" {
            result = "\(locality) \(subLocality)"
        } else {
            result = "\(administrativeArea) \(locality) \(subLocality)"
        }
        return result
    }
}
//37.389927, 126.950349 경기도
//37.518052, 126.957236 서울
//35.038194, 126.719222 // 나주
extension WeatherManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            fetchAddressName()
            locationManager.stopUpdatingLocation()
            fetchCurrentWeather()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 업데이트 실패: \(error.localizedDescription)")
    }
}
