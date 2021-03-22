//
//  RoadSituationContentView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import SwiftUI
import Sliders

struct RoadSituationContentView: View {
    @EnvironmentObject var userData:UserData
    @State var positionOfSelector:Float = 0
    var body: some View {
        let high = findLargest(trendList: userData.roadSituation.situation)
        VStack{
            TrendGraphView(trendList: userData.roadSituation.situation, point: $positionOfSelector)
                .frame(height: UIScreen.main.bounds.height/CGFloat(4*high)*CGFloat(high), alignment: .center)
            DigitalClockView(rate: $positionOfSelector, start: userData.roadSituation.situation[0].hour, end: userData.roadSituation.situation[userData.roadSituation.situation.count-1].hour, color: .blue)
            ValueSlider(value: $positionOfSelector)
                .frame(height:UIScreen.main.bounds.height/20)
        }
    }
    func findLargest(trendList:[OneHourRoadSituation]) -> Int{
        var largest:Int = 0
        for i in trendList{
            if i.high>largest{
                largest = i.high
            }
        }
        return largest
    }
}

struct RoadSituationContentView_Previews: PreviewProvider {
    static var previews: some View {
        RoadSituationContentView(positionOfSelector: 0.3)
            .environmentObject(UserData())
    }
}
