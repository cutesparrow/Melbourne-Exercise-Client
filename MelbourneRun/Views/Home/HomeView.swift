//
//  HomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI
import SDWebImageSwiftUI
import ActivityIndicatorView
import AlertToast
import CoreLocation

let screen = UIScreen.main.bounds


struct SystemMaterialView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<SystemMaterialView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<SystemMaterialView>) {
        
    }
    
}

class TicketCardView_Control: ObservableObject {
    @Published var anyTicketTriggered = false
}

struct ExpandableCardView: View {
    @Environment(\.managedObjectContext) var context
    @State var viewState = CGSize.zero
    @State var isDetectingLongPress = false
    @Binding var isSelected:Bool
    @Binding var networkError:Bool
    @Binding var loading:Bool
    @Binding var showBottomBar:Bool
    @State var selectedTab:Int = 0
    @EnvironmentObject var userData:UserData
    @FetchRequest(entity: AboutCovidCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AboutCovidCore.uid, ascending: true)]) var result: FetchedResults<AboutCovidCore>
    
    //MARK: Card size
    var normalCardHeight: CGFloat
    let normalCardHorizontalPadding: CGFloat = 16
    
    let openCardAnimation = Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)
    
    //MARK: Gestures
    var press: some Gesture {
        TapGesture()
            .onEnded { finished in
                withAnimation(self.openCardAnimation) {
                    self.isDetectingLongPress = true
                    self.isSelected = true
                    self.isDetectingLongPress = false
                    self.showBottomBar = false
                }
            }
    }
    
//    var longPressAndRelese: some Gesture {
//        DragGesture(minimumDistance: 0, coordinateSpace: .global)
//            .onChanged { _ in
//                withAnimation(.easeIn(duration: 0.15)) {
//                    self.isDetectingLongPress = true
//                }
//            }
//            .onEnded { _ in
//                withAnimation(self.openCardAnimation) {
//                    self.isSelected = true
//                    self.isDetectingLongPress = false
//                }
//            }
//    }
//    var dragSelectedCard: some Gesture {
//        DragGesture()
//            .onChanged { value in
//                self.viewState = value.translation
//            }
//            .onEnded { value in
//                self.viewState = .zero
//            }
//    }
    
//    func getShowInformation(){
//        let completion: (Result<ShowInformation,Error>) -> Void = { result in
//            switch result {
//            case let .success(information): self.showInformation = information
//                self.loading = false
//            case let .failure(error): print(error)
//                self.loading = false
//                self.networkError = true
//            }
//        }
//        self.loading = true
//        _ = NetworkAPI.loadShowInformation(completion: completion)
//
//    }
    
    //MARK: View Body
    var body: some View {
        
        if !result.isEmpty{
            VStack{
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        TopView(isSelected: self.$isSelected, selectedTab: $selectedTab, showBottomBar: $showBottomBar)
                            .environmentObject(userData)
                            .frame(height: self.normalCardHeight)
                        
                        if self.isSelected {
//                            ZStack{
//                                Color(hex: "0x00ffaa").ignoresSafeArea(.all)
//                                    .padding(.top,-9)
                                ExpandableView(isSelected: self.$isSelected, selectedTab: $selectedTab)
                                
                                
                            Spacer()
                                
//                            }
                        }
                    } //VStack
//                    .background(Color.white.opacity(0.01))
                    .background(Color(hex: "0x" + result[selectedTab].color!))
                    .offset(y: self.isSelected ? self.viewState.height/2 : 0)
                    .animation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1))
//                    .gesture(self.isSelected ? (self.dragSelectedCard) : (nil))
                } //ZStack
                //.drawingGroup() //test it
                
                //MARK: Card Appearance
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: self.isSelected ? 0 : 15, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
                .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 7)
                
                //MARK: Animation end effect (globa/local)
                .scaleEffect(self.isDetectingLongPress ? 0.95 : 1)
                ///           to test on preview change (in: .global) to (in: .local)
                ///            .offset(x: self.isSelected ? -geometry.frame(in: .local).minX : 0,
                ///                 y: self.isSelected ? -geometry.frame(in: .local).minY : 0)
                .offset(x: self.isSelected ? -geometry.frame(in: .global).minX : 0,
                        y: self.isSelected ? -geometry.frame(in: .global).minY : 0)
                
                .frame(height: self.isSelected ? screen.height : nil)
                .frame(width: self.isSelected ? screen.width : nil)
                
                .gesture(self.press)
//                .gesture(self.longPressAndRelese)
            } //GeometryReader
            .frame(width: screen.width - (normalCardHorizontalPadding * 2))
            .frame(height: normalCardHeight)
            
            
        }}
        else {
            EmptyView()
        }
//        .onAppear(perform: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
////                if true{
////                    self.getShowInformation()
////                    userData.homepageFistAppear = false
////                }
//
//            }
//        })
    }
    
}


//MARK: TopView
struct TopView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isSelected: Bool
    @FetchRequest(entity: AboutCovidCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AboutCovidCore.uid, ascending: true)]) var result: FetchedResults<AboutCovidCore>
    @Binding var selectedTab:Int
    @Binding var showBottomBar:Bool
    
    func getNumberOfLines(tips:String) -> Int{
        if tips.count <= 55{
            return 1
        }
        if tips.count <= 110{
            return 2
        }
        if tips.count <= 180{
            return 3
        }
        return 3
    }
    
    
    var body: some View {
        if !result.isEmpty{
            GeometryReader { geometry in
            ZStack {
                ZStack {
                    if !isSelected{
                        Image("covid")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                        .clipped()
                        
                    } else{
                        WebImage(url: URL(string: NetworkManager.shared.urlBasePath + result[selectedTab].background!))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                            .clipped()
                    }
                    if !isSelected{
                        VStack {
                        Spacer()
                        SystemMaterialView(style: .regular)
                            .frame(height: 35)
                    }}
                }
                VStack(alignment: .center, spacing: 0) {
                    if self.isSelected {
                        Rectangle()
                            .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.clear)
                    }
                    
                    //MARK: Upper part
                    HStack {
                        Spacer()
                        
                        if self.isSelected {
                            Button(action: {
                                    withAnimation(Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)) {
                                        self.isSelected = false
                                        self.showBottomBar = true
                                    }}) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(.white))
                                    .font(.system(size: 30, weight: .medium))
                                    .opacity(0.7)
                            }
                        }
                        if !self.isSelected{
                            VStack(alignment:.leading){
                                Text("USEFUL INFORMATION")
                                    .foregroundColor(.gray)
                                    .font(.body)
                                    .bold()
                                    .lineLimit(1)
                                Text("The Fact You Need To Know About Covid-19")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title2)
                                    .lineLimit(2)
                            }
                            .offset(x:-UIScreen.main.bounds.width/5.3)
                            .frame(width:UIScreen.main.bounds.width/1.5)
                            
                        }
                    } //HStack
                    .padding(.top)
                    .padding(.horizontal)
                    
                    
                    Spacer(minLength: 0)
                    
                    
                    //MARK: Bottom part
                    if !isSelected{HStack(alignment: .center) {
                        Text("Most Recent Update")
                            .foregroundColor(Color(.label).opacity(0.5))
                            .font(.body)
                            .bold()
                            .lineLimit(1)
                            .padding(.horizontal,22)
                            .padding(.bottom, 6)
                        Spacer()
                    }
                    }
                   
                }
            }
            
        }}
        else{
            EmptyView()
        }
    }
}



struct ExpandableView: View {
    @Binding var isSelected: Bool
//    @EnvironmentObject var userData:UserData
    @FetchRequest(entity: AboutCovidCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AboutCovidCore.uid, ascending: true)]) var result: FetchedResults<AboutCovidCore>
    @Binding var selectedTab:Int
    
    var body: some View {
        if !result.isEmpty{
            TabView(selection:$selectedTab){
                ForEach(self.result,id:\.uid){ data in
                ScrollView{
                    VStack{
                        PolicyView(policy: data)
                        .padding(.horizontal)
                    Spacer()
                }
                }
                .padding(.bottom,40)
                .tag(Int(data.uid))
            }
        }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
            .frame(height:UIScreen.main.bounds.height/1.65)
           
          
        //        Text(userData.safetyPolicy[1].content)
        //            .font(.body)
        //            .foregroundColor(Color(.label))
        //            .padding()
        //
        } else{
            EmptyView()
        }
    }
}


struct HomeView: View {
    @EnvironmentObject var userData:UserData
    @Binding var tutorial:Bool
    @Binding var bottomBarSelected:Int
    @Binding var showBottomBar:Bool
    @State var isSelected:Bool = false
    @State var isSelected2:Bool = false
    @State var showLoadingIndicator:Bool = false
    @State var networkError:Bool = false
    @State var showInformation:ShowInformation = ShowInformation(imageName: "", safetyTips: "", exerciseTips: "", exerciseBenefits: "")
    @State var showLocationPermissionAlert:Bool = false
    @State var showFavoriteGym:Bool = true
    @State var showFavoriteRoute:Bool = false
    @State var showFavoritePopularJoggingRoute:Bool = false
    @StateObject var aboutCovidViewModel:AboutCovidViewModel = AboutCovidViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: AboutCovidCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AboutCovidCore.uid, ascending: true)]) var result: FetchedResults<AboutCovidCore>
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
            
            
            HStack{
                Text(Date(),style: .date)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                Spacer(minLength: 0)
                MainWeatherView()
                    .offset(y:3)
                Spacer(minLength: 0)
                Button(action: {withAnimation{tutorial.toggle()}}, label: {
                    VStack{
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(AppColor.shared.homeColor)
                            .font(.system(size: 28, weight: .regular))
                        //                                                Text("Membership")
                        //                                                    .font(.caption2)
                    }
                })
                .offset(y:-1.5)
            }
            .padding(.horizontal)
            .zIndex(0)
            if !isSelected2{
                ExpandableCardView(isSelected:$isSelected, networkError: $networkError, loading: $showLoadingIndicator, showBottomBar: $showBottomBar, normalCardHeight: 260)
                .padding(.vertical)
            }
            if !isSelected{ExpandableTipsCardView(isSelected: $isSelected2, networkError: $networkError, loading: $showLoadingIndicator)
                .padding(.bottom)}
            if !isSelected && !isSelected2{
                HStack{
                    Button {
                        withAnimation{
                            self.showFavoriteRoute = false
                        self.showFavoritePopularJoggingRoute = false
                        self.showFavoriteGym.toggle()}
                        
                    } label: {
                        ZStack{
                            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x2E3192), Color(hex: 0x1BFFFF)]), startPoint: .leading, endPoint: .trailing)
                                .opacity(0.8)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                .frame(width: 110,height: 50)
                            VisualEffectView(effect: UIBlurEffect(style: .light))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: 110,height: 50)
                            HStack{
                                if showFavoriteGym{
                                    Text("✔")
                                    .bold()
                                    .font(.body)
                                    .foregroundColor(Color(.black))}
                                Text("GYM")
                                .bold()
                                .font(.title3)
                                .foregroundColor(Color(.white))}
                        }
                    }
                    Spacer(minLength: 0)
                    Button {
                        withAnimation{
                            self.showFavoritePopularJoggingRoute = false
                        self.showFavoriteGym = false
                        self.showFavoriteRoute.toggle()}
                    } label: {
                        ZStack{
                            LinearGradient(gradient: Gradient(colors: [Color(hex: 0xEA8D8D), Color(hex: 0xA890FE)]), startPoint: .leading, endPoint: .trailing)
                                .opacity(0.8)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                .frame(width: 110,height: 50)
                            VisualEffectView(effect: UIBlurEffect(style: .light))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: 110,height: 50)
                            HStack{
                                if showFavoriteRoute{Text("✔")
                                    .bold()
                                    .font(.body)
                                    .foregroundColor(Color(.black))}
                                Text("ROUTE")
                                .bold()
                                .font(.title3)
                                .foregroundColor(Color(.white))}
                        }
                    }
                    Spacer(minLength: 0)
                    Button {
                        withAnimation{
                            self.showFavoriteRoute = false
                            self.showFavoriteGym = false
                            self.showFavoritePopularJoggingRoute.toggle()}
                    } label: {
                        ZStack{
                            LinearGradient(gradient: Gradient(colors: [AppColor.shared.popularRouteColor, AppColor.shared.gymColor]), startPoint: .leading, endPoint: .trailing)
                                .opacity(0.8)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                .frame(width: 110,height: 50)
                            VisualEffectView(effect: UIBlurEffect(style: .light))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: 110,height: 50)
                            HStack{
                                if showFavoritePopularJoggingRoute{Text("✔")
                                    .bold()
                                    .font(.body)
                                    .foregroundColor(Color(.black))}
                                Text("JOG")
                                .bold()
                                .font(.title3)
                                .foregroundColor(Color(.white))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                if showFavoriteGym{
                    FavoriteGymScrollView(bottomBarSelected:$bottomBarSelected)
                        .transition(AnyTransition.opacity.combined(with: .slide))
                }
                if showFavoriteRoute{
                    FavoriteRouteScrollView(bottomBarSelected:$bottomBarSelected)
                        .transition(AnyTransition.opacity.combined(with: .slide))
                }
                if showFavoritePopularJoggingRoute{
                    FavoritePopularRouteSrollView(bottomBarSelected:$bottomBarSelected)
                        .transition(AnyTransition.opacity.combined(with: .slide))
                }
                    
            }
            Spacer()
        }
           
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        //            ZStack{
        //                ExpandableCardView(showInformation:$showInformation,networkError: $networkError, loading: $showLoadingIndicator)
        //            .environmentObject(userData)
        //            .offset(y:-UIScreen.main.bounds.height/15)
        //
                    .onAppear(perform: {
                        self.userData.getWeatherDataNow()
                        if result.isEmpty{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                                self.aboutCovidViewModel.getAboutCovidData(context: context)
                            }
                        }
                    })
        //
        //            ZStack{
        //                if showLoadingIndicator{
        //                    VisualEffectView(effect: UIBlurEffect(style: .light))
        //                    .clipShape(RoundedRectangle(cornerRadius: 15))
        //                    .frame(width: 60, height: 60, alignment: .center)}
        //                ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default)
        //                .frame(width: 40.0, height: 40.0)
        //                    .foregroundColor(AppColor.shared.homeColor)
        //
        //            }
                    .onAppear(perform: {
                        
                        if !userData.showedPermissionAlert{
                        let manager = CLLocationManager()
                        switch manager.authorizationStatus {
                        case .restricted, .denied:
                            showLocationPermissionAlert = true
                            userData.showedPermissionAlert = true
                        case .authorizedAlways,.authorizedWhenInUse:
                            showLocationPermissionAlert = false
                            userData.showedPermissionAlert = true
                        default:
                            showLocationPermissionAlert = false
                        }
                            print("1")
                        }
                        else{
                            print("2")
                        }
                    })
                    .toast(isPresenting: $showLocationPermissionAlert, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Permission", subTitle: "Location Needed")
                }, completion: {_ in
                    self.showLocationPermissionAlert = false
                })
                    .toast(isPresenting: $networkError, duration: 2.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
                    }, completion: {_ in
                        self.networkError = false
                    })
    }
}


