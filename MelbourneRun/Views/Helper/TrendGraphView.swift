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
    var body: some View {
        let trendList = Array(fullTrendList[8...])
        let high:Int = findLargest(trendList: trendList)
        let rate:CGFloat = UIScreen.main.bounds.height/CGFloat(5*high)
        let onFocus:Int = Int(point*Float(trendList.count)*0.99)
        
        return GeometryReader { proxy in
            VStack{
                Text(idtoday==0 ? "Today" : "Tomorrow")
                    .offset(x:-UIScreen.main.bounds.width/3,y:-UIScreen.main.bounds.height/20)
                HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                ForEach(trendList, id: \.hour) { hour in
                    GraphCapsule(high: hour.high, low: hour.low,  rate: Float(rate))
                        .colorMultiply(hour.hour == getHour(index: onFocus, trendList: trendList) ? getColorOfCapsule(OnHourRoadSituation: hour) : AppColor.shared.trendGraphColor)
                        .transition(.slide)
                        .animation(.spring())
                        .offset(x:0,y:-CGFloat(hour.low)*rate)
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

struct TrendGraphView_Previews: PreviewProvider {
    static var previews: some View {
        TrendGraphView(fullTrendList: [OneHourRoadSituation(hour: 8,high: 17, low: 1, average: 16),OneHourRoadSituation(hour: 9,high: 23, low: 21, average: 22),OneHourRoadSituation(hour: 10,high: 33, low: 26, average: 22),OneHourRoadSituation(hour: 11,high: 47, low: 46, average: 52),OneHourRoadSituation(hour: 12,high: 67, low: 44, average: 52),OneHourRoadSituation(hour: 13,high: 87, low: 76, average: 82),OneHourRoadSituation(hour: 14,high: 67, low: 46, average: 52),OneHourRoadSituation(hour: 15,high: 55, low: 46, average: 52)], idtoday: 0, point: .constant(0.99))
    }
}
