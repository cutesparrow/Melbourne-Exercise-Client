//
//  MapStyle.swift
//  MelbExercise
//
//  Created by gaoyu shi on 9/5/21.
//

import Foundation
import MapboxNavigation

class CustomDayStyle: DayStyle {
    required init() {
        super.init()
//        mapStyleURL = URL(string: "mapbox://styles/mapbox/satellite-streets-v9")!
//        previewMapStyleURL = mapStyleURL
        styleType = .day
    }
    
    override func apply() {
        super.apply()
        BottomBannerView.appearance().backgroundColor = .white
        
    }
}

// MARK: CustomNightStyle
class CustomNightStyle: NightStyle {
    required init() {
        super.init()
//        mapStyleURL = URL(string: "mapbox://styles/mapbox/satellite-streets-v9")!
//        previewMapStyleURL = mapStyleURL
        styleType = .night
    }
    
    override func apply() {
        super.apply()
        BottomBannerView.appearance().backgroundColor = .black
        TopBannerView.appearance().backgroundColor = .black
        InstructionsBannerView.appearance().backgroundColor = .black
    }
}
