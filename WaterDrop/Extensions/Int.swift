//
//  String.swift
//  WaterDrop
//
//  Created by Remigiusz Makuchowski on 18/08/2022.
//

import Foundation

extension Int {
     var withLeadingZeros: String {
        return String(format: "%02d", self)
    }
}
