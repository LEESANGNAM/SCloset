//
//  Date+Extension.swift
//  SCloset
//
//  Created by 이상남 on 12/1/23.
//

import Foundation

extension Date {
    func yyyyMMddFormattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
