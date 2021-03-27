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
    var day:Int
    @State var positionOfSelector:Float = 0
    var body: some View {
        let high = findLargest(trendList: userData.roadSituation.list[day].situation)
        VStack{
            ScrollView{
                LazyHStack{
                    TabView{
                        ForEach(0..<2){i in
                            TrendGraphView(fullTrendList: userData.roadSituation.list[i].situation, idtoday: i, point: $positionOfSelector)
                                    .frame(height: UIScreen.main.bounds.height/CGFloat(4*high)*CGFloat(high), alignment: .center)
                        }
                    }.frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/CGFloat(2.8*Double(high))*CGFloat(high))
                    .tabViewStyle(PageTabViewStyle())
                    
                }
            }.padding(.top,-40)
            .frame(height:UIScreen.main.bounds.height/CGFloat(3*Double(high))*CGFloat(high))
            DigitalClockView(rate: $positionOfSelector, start: userData.roadSituation.list[day].situation[8].hour, end: userData.roadSituation.list[day].situation[userData.roadSituation.list[day].situation.count-1].hour, color: .blue)
            ValueSlider(value: $positionOfSelector)
                .frame(height:UIScreen.main.bounds.height/20)
                .padding(.horizontal)
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
        RoadSituationContentView(day: 0, positionOfSelector: 0.3)
            .environmentObject(UserData())
    }
}
