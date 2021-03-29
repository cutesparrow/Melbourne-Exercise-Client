//
//  PlanView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 22/3/21.
//

import SwiftUI
import MapKit
import EventKit
import AlertX
import Sliders
import AlertToast
import PositionScrollView




struct PlanView: View,PositionScrollViewDelegate {
    @EnvironmentObject var userData:UserData
    var pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
    @ObservedObject var psViewModel = PositionScrollViewModel(
        pageSize: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3),
        horizontalScroll: Scroll(
            scrollSetting: ScrollSetting(pageCount: 2, afterMoveType: .fitToNearestUnit),
            pageLength: UIScreen.main.bounds.width
        )
    )
    @State var pageNow = 0
    @Binding var isShown:Bool
    @State var showAlertX:Bool = false
    @State var saveSuccess:Bool = false
    @State var saveFailure:Bool = false
    var day = 0
    @State var positionOfSelector:Float = 0
    
    public func onScrollStart() {
        print("onScrollStart")
    }
    public func onChangePage(page: Int) {
        self.pageNow = page
        print("onChangePage to page: \(page)")
    }
    
    public func onChangePosition(position: CGFloat) {
        print("position: \(position)")
    }
    
    public func onScrollEnd() {
        print("onScrollEnd")
    }
    var body: some View {
        let high = findLargest(trendList: userData.roadSituation.list[day].situation)
        VStack{
            VStack{
                PositionScrollView(
                    viewModel: self.psViewModel,
                    delegate: self
                ){
                    LazyHStack{
                        
                        ForEach(0..<2){i in
                            TrendGraphView(fullTrendList: userData.roadSituation.list[i].situation, idtoday: i, point: $positionOfSelector)
                                .frame(width:UIScreen.main.bounds.width-8 ,height: UIScreen.main.bounds.height/CGFloat(4*high)*CGFloat(high), alignment: .center)
                        }
                        
                    }
                }
                .padding(.top,-40)
                .frame(height:UIScreen.main.bounds.height/CGFloat(3*Double(high))*CGFloat(high))
                LegendView()
                DigitalClockView(rate: $positionOfSelector, start: userData.roadSituation.list[day].situation[8].hour, end: userData.roadSituation.list[day].situation[userData.roadSituation.list[day].situation.count-1].hour, color: .blue)
                    .environmentObject(userData)
                ValueSlider(value: $positionOfSelector)
                    .frame(height:UIScreen.main.bounds.height/20)
                    .padding(.horizontal)
            }
            .environmentObject(userData)
            .padding()
            HStack{
                Spacer()
                Button(action: {isShown.toggle()}, label: {
                    DirectButtonView(color: Color.gray, text: "Cancel")
                })
                Spacer()
                Button(action: {
                    self.showAlertX.toggle()
                }, label: {
                    DirectButtonView(color: AppColor.shared.gymColor, text: "Plan")
                })
                Spacer()
            }
        }
        .toast(isPresenting: $saveSuccess, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .complete(Color.green), title: "Saved", subTitle: "")
        }, completion: {_ in
            self.saveSuccess = false
        })
        .toast(isPresenting: $saveFailure, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(Color.red), title: "Failure", subTitle: "")
        }, completion: {_ in
            self.saveFailure = false
        })
        .frame(width:UIScreen.main.bounds.width)
        .alertX(isPresented: $showAlertX) {
            AlertX(title: Text("Confirm Plan"), message: Text("""
Target Gym: \(userData.selectedGym.name)
Time: \(getTimeString(date: getTime(start: userData.roadSituation.list[day].situation[8].hour, end: userData.roadSituation.list[day].situation[userData.roadSituation.list[day].situation.count-1].hour, rate: positionOfSelector)))
Note: \(userData.selectedGym.address)
"""), primaryButton: .cancel(), secondaryButton: .default(Text("Save"), action: {
    saveIntoEvent(title: "Go to \(userData.selectedGym.name)", date: getTime(start: userData.roadSituation.list[day].situation[8].hour, end: userData.roadSituation.list[day].situation[userData.roadSituation.list[day].situation.count-1].hour, rate: positionOfSelector), notes: userData.selectedGym.address)
}), theme: .graphite(withTransparency: true, roundedCorners: true), animation: .classicEffect())
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
    
    func getTimeString(date:Date) -> String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .short
        return formatter1.string(from: date)
    }
    
    func getTime(start:Int,end:Int,rate:Float) -> Date{
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone(abbreviation: "AEST"),year: year, month: month, day: day, hour: start, minute: 0, second: 0)
        let totalMinutes:Int = (end - start + 1) * 60
        var gapMinutes:Int = Int(Float(totalMinutes) * rate * 60)
        if self.pageNow == 1{
            gapMinutes = gapMinutes + 24*60*60
        }
        let nowTime = Date(timeInterval: Double(gapMinutes), since: dateComponents.date!)
        return nowTime
    }
    
    func saveIntoEvent(title:String,date:Date,notes:String){
        let eventStore : EKEventStore = EKEventStore()
        
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(String(describing: error ?? nil))")
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = date
                event.endDate = Date(timeInterval: 5400, since: date)
                event.notes = notes
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                    self.saveFailure.toggle()
                }
                self.saveSuccess.toggle()
                print("Saved Event")
            }
            else{
                self.saveFailure.toggle()
                print("failed to save event with error : \(String(describing: error)) or access not granted")
            }
        }
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(isShown: .constant(false))
            .environmentObject(UserData())
    }
}
