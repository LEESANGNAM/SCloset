//
//  TodayWeatherModel.swift
//  SCloset
//
//  Created by 이상남 on 12/1/23.
//

import Foundation

struct TodayWeatherModel {
    let date : String
    let location: String
    let highTemperature: Measurement<UnitTemperature>
    let lowTemperature: Measurement<UnitTemperature>
    let symbolName: String
}
