//
//  TrendGraphView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import SwiftUI



struct TrendGraphView: View {
    var fullTrendList:[OneHourRoadSituation]
    var idtoday:Int
    @Binding var point:Float
    var start:String
    var close:String
    var body: some View {
        let start = start.split(separator: ":")
        let close = close.split(separator: ":")
        let trendList = Array(fullTrendList[Int(start[0])!...Int(close[0])!])
        let high:Int = findLargest(trendList: trendList)
        let low:Int = findLowest(trendList: trendList)
        let rate:CGFloat = UIScreen.main.bounds.height/CGFloat(5*high)
        let onFocus:Int = Int(point*Float(trendList.count)*0.99)
        
        return GeometryReader { proxy in
            VStack{
                Text(idtoday==0 ? Date() : Date(timeInterval: 24*60*60, since: Date()),style: .date)
                    .offset(x:-UIScreen.main.bounds.width/3,y:-UIScreen.main.bounds.height/20)
                HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                ForEach(trendList, id: \.hour) { hour in
                    GraphCapsule(high: hour.high, low: hour.low,  rate: Float(rate))
                        .colorMultiply(hour.hour == getHour(index: onFocus, trendList: trendList) ? getColorOfCapsule(OnHourRoadSituation: hour) : AppColor.shared.trendGraphColor)
                        .transition(.slide)
                        .animation(.spring())
                        .offset(x:0,y:-CGFloat(hour.low)*rate + CGFloat(low/9))
                        //.padding()
                }
                
            }.offset(y:proxy.size.height/2.5)}
        }.padding(.bottom,80)
    }
    
    func getColorOfCapsule(OnHourRoadSituation:OneHourRoadSituation) -> Color{
        let average = OnHourRoadSituation.average
        let riskLevel:RiskLevel = StandardRiskAssessment.shared.getRiskLevel(average: average)
        switch riskLevel {
        case .no:
            return AppColor.shared.noRiskColor
        case .low:
            return AppColor.shared.lowRiskColor
        case .mid:
            return AppColor.shared.midRiskColor
        case .high:
            return AppColor.shared.highRiskColor
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
    func findLowest(trendList:[OneHourRoadSituation]) -> Int{
        var lowest:Int = 0
        for i in trendList{
            if i.low>lowest{
                lowest = i.low
            }
        }
    
        return lowest
    }
    
    func getHour(index:Int,trendList:[OneHourRoadSituation]) -> Int{
        trendList[index].hour
    }
}

//extension Animation {
//    static func ripple(index: Int) -> Animation {
//        Animation.spring(dampingFraction: 0.5)
//            .speed(2)
//            .delay(0.03 * Double(index))
//    }
//}

