//
//  GymListView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 18/3/21.
//

import SwiftUI
import MapKit
import SwiftUIRefresh
import ActivityIndicatorView
import AlertToast

struct GymListView: View {
    @EnvironmentObject var userData:UserData
    @Binding var gymList:GymList
    @State private var isShowing = false
    @State private var showLoadingIndicator = false
    @State private var networkError:Bool = false
    func loadGymListData(location:CLLocationCoordinate2D){
        let completion: (Result<GymList, Error>) -> Void = { result in
            switch result {
            case let .success(list): self.gymList = list
                self.showLoadingIndicator = false
            case let .failure(error): print(error)
                self.showLoadingIndicator = false
                self.networkError = true
            }
        }
        self.showLoadingIndicator = true
        _ = NetworkAPI.loadGymList(location: location, completion: completion)
    }
    var body: some View {
            
            
            ZStack{
                List{
                ForEach(self.gymList.list) { gym in
                    if gym.classType == userData.hasMemberShip || userData.hasMemberShip == "No membership" {NavigationLink(destination: GymRecordView(gymList: $gymList, gym: gym)) {
                    GymCellView(gym: gym)
                        .padding(.top,10)
                        .padding(.bottom,10)
                        .shadow(radius: 0 )
                }}
            }
            }
                ZStack{
                    if showLoadingIndicator{
                        VisualEffectView(effect: UIBlurEffect(style: .light))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 60, height: 60, alignment: .center)}
                    ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default)
                    .frame(width: 40.0, height: 40.0)
                        .foregroundColor(AppColor.shared.gymColor)}
            }
            .toast(isPresenting: $networkError, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
            }, completion: {_ in
                self.networkError = false
            })
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                    if true{
                self.loadGymListData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
                userData.gympageFirstAppear = false
            }}
            })
            .pullToRefresh(isShowing: $isShowing) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.loadGymListData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
                    self.isShowing = false
                }
            }.onChange(of: self.isShowing) { value in
            }
    }
    
    
}

struct GymListView_Previews: PreviewProvider {
    static let data = UserData()
    static var previews: some View {
        GymListView(gymList: .constant(GymList(list: [])))
            .environmentObject(data)
    }
}

