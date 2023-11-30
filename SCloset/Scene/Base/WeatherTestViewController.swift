//
//  WeatherTestViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/30/23.
//

import UIKit
import WeatherKit
import CoreLocation


class WeatherTestViewController: UIViewController {
    
    let weatherService = WeatherService()
    var locationManager = CLLocationManager()
//    let syracuse =
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
    }
    
}

extension WeatherTestViewController: CLLocationManagerDelegate {
    
    
    private func setLocationManager() {
        locationManager.delegate = self
        // 거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치사용 알림
        locationManager.requestWhenInUseAuthorization()
        
//        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
//        } else {
//            print("위치서비스 허용안함 처리해야함")
//        }
        
    }
    func getWeather(location: CLLocation) {
        Task{
            do{
               let result =  try await weatherService.weather(for: location)
                
                let dateFormatter = DateFormatter()
                       dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
                       dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let koreaDate = dateFormatter.string(from: result.currentWeather.date)
                print("날씨정보:")
                print("바꾸기전 날짜: ", result.currentWeather.date)
                print("오늘날짜 : ", koreaDate)
                print(result)
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("currentMetadata: ",result.currentWeather.symbolName)
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("Current: ",result.currentWeather)
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("daily count :",result.dailyForecast.count)
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("dailyMetadata : ",result.dailyForecast.metadata)
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("daily first :",result.dailyForecast.first!)
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("daily: ",result.dailyForecast.forecast.first!.date)
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("daily1: ",result.dailyForecast.forecast[0])
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("daily2: ",result.dailyForecast.forecast[1])
                print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
                print("minute: ",result.minuteForecast)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
            locationManager.stopUpdatingLocation()
            getWeather(location: location)
        }
    }
    
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}


/*
Weather(
    currentWeather: date=2023-11-30 00:49:11 +0000,
                    expirationDate=2023-11-30 00:54:11 +0000,
                    condition=Clear,
                    temperature=-5.16 °C,
    minuteForecast: nil,
    hourlyForecast: hours count=249,
                    date range=2023-11-29 14:00:00 +0000 to 2023-12-09 22:00:00 +0000,
                    first condition=Mostly Clear,
                    first temperature=-4.16 °C,
                    last condition=Clear,
                    last temperature=6.09 °C,
    dailyForecast: days count=10,
                    date range=2023-11-29 15:00:00 +0000 to 2023-12-08 15:00:00 +0000,
                    first condition=Clear,
                    first high=-0.37 °C,
                    first low=-7.25 °C,
                    last condition=Partly Cloudy,
                    last high=6.98 °C,
                    last low=-2.82 °C,
    weatherAlerts: nil,
 
    availability: WeatherKit.WeatherAvailability(
                    minuteAvailability: WeatherKit.WeatherAvailability.AvailabilityKind.unsupported,
                    alertAvailability: WeatherKit.WeatherAvailability.AvailabilityKind.unsupported,
                    airQualityAvailability: WeatherKit.WeatherAvailability.AvailabilityKind.unsupported
                    ),
    airQuality: nil,
    weatherChange: nil,
    appLocationConfig: nil,
    news: nil
 )
*/
