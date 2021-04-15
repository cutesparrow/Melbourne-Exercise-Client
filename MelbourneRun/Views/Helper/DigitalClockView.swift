//
//  DigitalClockView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import SwiftUI

struct DigitalClockView: View {
    @Binding var rate: Float
    
    let start:Int
    let end:Int
    
    var body: some View {
        let totalMinutes:Int = (end - start + 1) * 60
        let gapMinutes:Int = Int(Float(totalMinutes) * rate * 60)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startTime = formatter.date(from: String(start) + ":00")!
        let nowTime = Date(timeInterval: Double(gapMinutes), since: startTime)
        //userData.selectedTime = nowTime
        return Text(nowTime,style: .time)
            .font(.system(.largeTitle, design: .rounded))
            .foregroundColor(Color.blue)
            .shadow(radius: 5 )
    }
}


