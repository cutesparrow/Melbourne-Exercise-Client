//
//  testView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 8/4/21.
//

import SwiftUI
import FloatingButton
import MapKit




struct MainButton: View {
    
    var imageName: String
    var color: Color

    var width: CGFloat = 50

    var body: some View {
        ZStack {
            color
                .frame(width: width, height: width)
                .cornerRadius(width/2)
                .shadow(color: color.opacity(0.3), radius: 15, x: 0, y: 15)
            Image(systemName: imageName).foregroundColor(.white)
        }
    }
}


struct IconAndTextButton: View {
    @Binding var loading:Bool
    @Binding var networkError:Bool
    @State var selectedSheet:String
    @EnvironmentObject var userData:UserData
    @Binding var mainswitch:Bool
    @Binding var isshow:Bool
    @Binding var sheetKind:Int
    @Binding var customizedCards:[CustomizedCard]
    @Binding var popularCards:[PopularCard]
    @Binding var loaded:Bool
    var imageName: String
    var buttonText: String
    let imageWidth: CGFloat = 22
    func loadCustomizedCardsData(location:CLLocationCoordinate2D){
        let completion: (Result<[CustomizedCard], Error>) -> Void = { result in
            switch result {
            case let .success(list): self.customizedCards = list
                self.loading = false
                self.loaded = true
                self.isshow.toggle()
                self.mainswitch.toggle()
            case let .failure(error): print(error)
                self.loading = false
                self.loaded = false
                self.networkError = true
            }
            
        }
        self.loading = true
        _ = NetworkAPI.loadCustomizedCards(location: location, completion: completion)
    }
    func loadPopularCardsData(location:CLLocationCoordinate2D){
        let completion: (Result<[PopularCard], Error>) -> Void = { result in
            switch result {
            case let .success(list): self.popularCards = list
                self.loading = false
                self.loaded = true
                self.isshow.toggle()
                self.mainswitch.toggle()
            case let .failure(error): print(error)
                self.loading = false
                self.loaded = false
                self.networkError = true
            }
            
        }
        self.loading = true
        _ = NetworkAPI.loadPopularCards(location: location, completion: completion)
    }
    var body: some View {
        Button(action: {
            if selectedSheet == "popular"{
                sheetKind = 1
            } else{
                sheetKind = 2
            }
            if selectedSheet == "popular"{
                self.loadPopularCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
            }
            else{
                self.loadCustomizedCardsData(location: checkUserLocation(lat: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, long: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) ? CLLocationCoordinate2D(latitude: userData.locationFetcher.lastKnownLocation?.latitude ?? -37.810489070978186, longitude: userData.locationFetcher.lastKnownLocation?.longitude ?? 144.96290632581503) : CLLocationCoordinate2D(latitude: -37.810489070978186, longitude: 144.96290632581503))
            }
        }, label: {
            ZStack {
                Color.white
                HStack {
                    Image(systemName: self.imageName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(Color(hex: "778ca3"))
                        .frame(width: self.imageWidth, height: self.imageWidth)
                        .clipped()
                    Spacer()
                    Text(buttonText)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(Color(hex: "4b6584"))
                    Spacer()
                }.padding(.leading, 15).padding(.trailing, 15)
            }
            .frame(width: 160, height: 45)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "F4F4F4"), lineWidth: 1)
            )
        })
    }
}

struct MockData {

    static let iconAndTextImageNames = [
        "star.circle",
        "pencil.circle"
    ]

    static let iconAndTextTitles = [
        "Popular",
        "Customize"
    ]
}

extension Color {
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    
}
