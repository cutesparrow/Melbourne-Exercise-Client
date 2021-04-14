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
    @Binding var showInformation:ShowInformation
    @State var viewState = CGSize.zero
    @State var isDetectingLongPress = false
    @State var isSelected = false
    @Binding var networkError:Bool
    @Binding var loading:Bool
    
    @EnvironmentObject var userData:UserData
    
    //MARK: Card size
    let normalCardHeight: CGFloat = 300
    let normalCardHorizontalPadding: CGFloat = 20
    
    let openCardAnimation = Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)
    
    //MARK: Gestures
    var press: some Gesture {
        TapGesture()
            .onEnded { finished in
                withAnimation(self.openCardAnimation) {
                    self.isDetectingLongPress = true
                    self.isSelected = true
                    self.isDetectingLongPress = false
                }
            }
    }
    
    var longPressAndRelese: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { _ in
                withAnimation(.easeIn(duration: 0.15)) {
                    self.isDetectingLongPress = true
                }
            }
            .onEnded { _ in
                withAnimation(self.openCardAnimation) {
                    self.isSelected = true
                    self.isDetectingLongPress = false
                }
            }
    }
    var dragSelectedCard: some Gesture {
        DragGesture()
            .onChanged { value in
                self.viewState = value.translation
            }
            .onEnded { value in
                self.viewState = .zero
            }
    }
    
    func getShowInformation(){
        let completion: (Result<ShowInformation,Error>) -> Void = { result in
            switch result {
            case let .success(information): self.showInformation = information
                self.loading = false
            case let .failure(error): print(error)
                self.loading = false
                self.networkError = true
            }
        }
        self.loading = true
        _ = NetworkAPI.loadShowInformation(completion: completion)
        
    }
    
    //MARK: View Body
    var body: some View {
        
        VStack{
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        TopView(isSelected: self.$isSelected, showInformation: $showInformation)
                            .environmentObject(userData)
                            .frame(height: self.normalCardHeight)
                        
                        if self.isSelected {
                            ExpandableView(isSelected: self.$isSelected, showInformation: $showInformation)
                                .environmentObject(userData)
                            
                            Spacer()
                        }
                    } //VStack
                    .background(Color.white.opacity(0.01))
                    .offset(y: self.isSelected ? self.viewState.height/2 : 0)
                    .animation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1))
                    .gesture(self.isSelected ? (self.dragSelectedCard) : (nil))
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
                .gesture(self.longPressAndRelese)
            } //GeometryReader
            .frame(width: screen.width - (normalCardHorizontalPadding * 2))
            .frame(height: normalCardHeight)
            if isSelected == false
            {
                HStack{
                    Text(Date(),style: .date)
                        .font(.system(.title))
                        .foregroundColor(Color(.label))
                        .lineLimit(1)
                    Spacer()
                    Button(action: {self.userData.getPosterName()
                            self.getShowInformation()}, label: {
                                MainStyleButton(icon: "arrow.triangle.2.circlepath", color: Color(.label), text: "")
                            })
                }
                .frame(width:UIScreen.main.bounds.width/1.13)
                .padding()
            }
            if isSelected == false{
                MainWeatherView()
                    .frame(width:UIScreen.main.bounds.width/1.03,height:130)
                
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){if true{
                self.getShowInformation()
                userData.homepageFistAppear = false
            }}
        })
    }
    
}


//MARK: TopView
struct TopView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isSelected: Bool
    @Binding var showInformation:ShowInformation
    
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
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    WebImage(url: URL(string: NetworkManager.shared.urlBasePath + self.showInformation.imageName))
                        .resizable()
                        .placeholder{
                            Color.gray
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                        .clipped()
                    VStack {
                        Spacer()
                        SystemMaterialView(style: .regular)
                            .frame(height: CGFloat(getNumberOfLines(tips: self.isSelected ? self.showInformation.safetyTips : self.showInformation.exerciseBenefits) * 55) / 3 + 10)
                    }
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
                                    }}) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(.white))
                                    .font(.system(size: 30, weight: .medium))
                                    .opacity(0.7)
                            }
                        }
                    } //HStack
                    .padding(.top)
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    //MARK: Middle part
                    Spacer()
                    
                    
                    //MARK: Bottom part
                    HStack(alignment: .center) {
                        Text(self.isSelected ? self.showInformation.safetyTips : self.showInformation.exerciseBenefits)
                            .foregroundColor(Color(.label))
                            .font(.caption)
                            .lineLimit(getNumberOfLines(tips: self.isSelected ? self.showInformation.safetyTips : self.showInformation.exerciseBenefits))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 6)
                }
            }
            .navigationBarHidden(isSelected)
        }
    }
}

//MARK: BottomView

struct ExpandableView: View {
    @Binding var isSelected: Bool
    @Binding var showInformation:ShowInformation
    @EnvironmentObject var userData:UserData
    
    
    var body: some View {
        TabView{
            ForEach(userData.safetyPolicy){ policy in
                ScrollView{VStack{
                    PolicyView(policy: policy)
                        .padding(.horizontal)
                    Spacer()
                }}
                .frame(height:UIScreen.main.bounds.height/2.5)
            }
        }.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode:.automatic))
        
        .frame(height:UIScreen.main.bounds.height/2)
        //        Text(userData.safetyPolicy[1].content)
        //            .font(.body)
        //            .foregroundColor(Color(.label))
        //            .padding()
        //
        
    }
}


struct HomeView: View {
    @EnvironmentObject var userData:UserData
    @State var showLoadingIndicator:Bool = false
    @State var networkError:Bool = false
    @State var showInformation:ShowInformation = ShowInformation(imageName: "", safetyTips: "", exerciseTips: "", exerciseBenefits: "")
    var body: some View {
            ZStack{
                ExpandableCardView(showInformation:$showInformation,networkError: $networkError, loading: $showLoadingIndicator)
            .environmentObject(userData)
            .offset(y:-UIScreen.main.bounds.height/15)
                
            .onAppear(perform: {
                self.userData.getWeatherDataNow()
                self.userData.getSafePolicy()
            })
                
            ZStack{
                if showLoadingIndicator{
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 60, height: 60, alignment: .center)}
                ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default)
                .frame(width: 40.0, height: 40.0)
                    .foregroundColor(AppColor.shared.homeColor)
                
            }
        }
            .toast(isPresenting: $networkError, duration: 1.2, tapToDismiss: true, alert: { AlertToast(type: .error(.red), title: "Network Error", subTitle: "")
            }, completion: {_ in
                self.networkError = false
            })
    }
}


