//
//  String+Extension.swift
//  SCloset
//
//  Created by 이상남 on 12/14/23.
//

import Foundation

extension String {
    func toDate() -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
           return dateFormatter.date(from: self)
       }
}
