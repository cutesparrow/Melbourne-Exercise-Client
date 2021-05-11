//
//  TipsCard.swift
//  MelbExercise
//
//  Created by gaoyu shi on 26/4/21.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI
import ActivityIndicatorView
import AlertToast
import CoreLocation




struct MaterialView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<MaterialView>) -> UIView {
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
                      context: UIViewRepresentableContext<MaterialView>) {
        
    }
    
}

class TicketCardViewControl: ObservableObject {
    @Published var anyTicketTriggered = false
}

struct ExpandableTipsCardView: View {
    
    @State var viewState = CGSize.zero
//    @State var isDetectingLongPress = false
    @Binding var isSelected:Bool
    @Binding var networkError:Bool
    @Binding var loading:Bool
    @Binding var showBottomBar:Bool
    @EnvironmentObject var userData:UserData
    
    //MARK: Card size
    let normalCardHeight: CGFloat = 260
    let normalCardHorizontalPadding: CGFloat = 16
    
    let openCardAnimation = Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)
    
    //MARK: Gestures
    var press: some Gesture {
        TapGesture()
            .onEnded { finished in
                withAnimation(self.openCardAnimation) {
//                    self.isDetectingLongPress = true
                    self.isSelected = true
//                    self.isDetectingLongPress = false
                    self.showBottomBar = false
                }
            }
    }
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
        
        VStack{
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing:0) {
                        TopPartView(isSelected: self.$isSelected, showBottomBar: $showBottomBar)
                            .environmentObject(userData)
                            .frame(height: isSelected ? 150 : self.normalCardHeight)
                        
                        if self.isSelected {
                            ExpandableTipsView(isSelected: self.$isSelected)
                                .environmentObject(userData)
                            
                            Spacer()
                        }
                    } //VStack
                    .background(Color.white.opacity(0.01))
                    .offset(y: self.isSelected ? self.viewState.height/2 : 0)
                    .animation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1))
                } //ZStack
                //.drawingGroup() //test it
                
                //MARK: Card Appearance
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: self.isSelected ? 0 : 15, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
                .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 7)
                
                //MARK: Animation end effect (globa/local)
//                .scaleEffect(self.isDetectingLongPress ? 0.95 : 1)
                ///           to test on preview change (in: .global) to (in: .local)
                ///            .offset(x: self.isSelected ? -geometry.frame(in: .local).minX : 0,
                ///                 y: self.isSelected ? -geometry.frame(in: .local).minY : 0)
                .offset(x: self.isSelected ? -geometry.frame(in: .global).minX : 0,
                        y: self.isSelected ? -geometry.frame(in: .global).minY : 0)
                
                .frame(height: self.isSelected ? screen.height : nil)
                .frame(width: self.isSelected ? screen.width : nil)
                .gesture(self.press)
                
            } //GeometryReader
            .frame(width: screen.width - (normalCardHorizontalPadding * 2))
            .frame(height: isSelected ? 150 : self.normalCardHeight)
            
            
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
//                if true{
//                    self.getShowInformation()
//                    userData.homepageFistAppear = false
//                }
                
            }
        })
    }
    
}


//MARK: TopPartView
struct TopPartView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isSelected: Bool
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
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Image(isSelected ? "effective exercse" : "exerciseTips")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                        .clipped()
//                    VStack {
//                        Spacer()
//                        MaterialView(style: .regular)
//                            .frame(height: 35)
//                    }
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
//                                Text("USEFUL TIPS")
//                                    .foregroundColor(.gray)
//                                    .font(.body)
//                                    .bold()
//                                    .lineLimit(1)
//                                Spacer()
//                                    .frame(height:70)
                                Text("Tips For Exercising")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title2)
                                    .lineLimit(2)
                            }
                            .offset(x:-UIScreen.main.bounds.width/3.15)
                            
                            
                            
                        }
                    } //HStack
                    .padding(.top)
                    .padding(.horizontal)
                    
                    
                    Spacer(minLength: 0)
                    //MARK: Middle part
                    Spacer(minLength: 0)
                    
                    
//                    //MARK: Bottom part
//                    HStack(alignment: .center) {
//                        Text("Most Recent Update")
//                            .foregroundColor(Color(.label).opacity(0.5))
//                            .font(.body)
//                            .bold()
//                            .lineLimit(1)
//
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom, 6)
                }
            }
            
        }
    }
}

//MARK: BottomView

struct ExpandableTipsView: View {
    @Binding var isSelected: Bool
    @EnvironmentObject var userData:UserData
    @State var leftPercent:CGFloat = 0
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: ExerciseTipsCore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseTipsCore.uid, ascending: true)]) var result: FetchedResults<ExerciseTipsCore>
    func scaleValue(mainFrame : CGFloat,minY : CGFloat)-> CGFloat{
        withAnimation(.easeOut){
            let scale = (minY - 25) / mainFrame
            if scale > 1{
                
                return 1
            }
            else{
                
                return scale
            }
        }
    }
    var body: some View {
        VStack{
            VStack{
                HStack{
            Button(action: {
                withAnimation {

                    self.leftPercent = 0
                }
            }, label: {
                Text("GYM")
                    .foregroundColor(Color(.label))
                    .bold()
                    .opacity(leftPercent == 0 ? 1 : 0.5)
            })
            .frame(width:UIScreen.main.bounds.width/6)
            Spacer(minLength: 0)
            
            Button(action: {
                withAnimation {

                    self.leftPercent = 1/3
                }
            }, label: {
                Text("JOG")
                    .foregroundColor(Color(.label))
                    .bold()
                    .opacity(leftPercent == 1/3 ? 1 : 0.5)
            })
            .frame(width:UIScreen.main.bounds.width/6)
                Spacer(minLength: 0)
            
            Button(action: {
                withAnimation {

                    self.leftPercent = 2/3
                }
            }, label: {
                Text("DOG")
                    .foregroundColor(Color(.label))
                    .bold()
                    .opacity(leftPercent == 2/3 ? 1 : 0.5)
            })
            .frame(width:UIScreen.main.bounds.width/6)
                Spacer(minLength: 0)
            
            Button(action: {
                withAnimation {
                    self.leftPercent = 1
                }
            }, label: {
                Text("CYCLE")
                    .foregroundColor(Color(.label))
                    .bold()
                    .opacity(leftPercent == 1 ? 1 : 0.5)
            })
            .frame(width:UIScreen.main.bounds.width/6)
            
            }
            .padding(.bottom,-2)
//            .background(Color.blue)
            .padding(.horizontal)
                
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(Color(hex:0x87ceeb))
                    .frame(width: 30, height: 4)
                    .offset(x:( 0.085 + 0.75 * self.leftPercent) * geometry.size.width)
            }
            .frame(height: 6,alignment: .center)}
                .padding(.top)
                .padding(.bottom,5)
                .background(Color(.systemBackground).shadow(color: Color.black.opacity(0.18), radius: 5, x: 0, y: 5))
            if leftPercent == 0 {
//                Color.blue
                GeometryReader{mainView in

                    ScrollView{

                        VStack(spacing: 10){

                            ForEach(self.result){tip in
                                if tip.tipClass == "Gym"{
                                GeometryReader{item in
                                    TipCellView(hight:120,content:tip.content)
                                        .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY),anchor: .bottom)

                                        .opacity(Double(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                                }
                                .frame(height:120)
                                }
                            }
                            Spacer()
                                .frame(height:25)
                        }
                        .padding(.leading,10)
                        .padding(.top,25)
                    }
                    .zIndex(1)
                }
                    .ignoresSafeArea(.all)
            }
            else if leftPercent == 1/3 {
                GeometryReader{mainView in

                    ScrollView{

                        VStack(spacing: 10){

                            ForEach(self.result){tip in
                                if tip.tipClass == "Jogging"{
                                GeometryReader{item in
                                    TipCellView(hight:120,content:tip.content)
                                        .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY),anchor: .bottom)
                                        .opacity(Double(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                                }
                                .frame(height:120)
                                }
                            }
                            Spacer()
                                .frame(height:25)
//                            Spacer()
//                                .frame(height:85)
                        }
                        .padding(.leading,10)
                        .padding(.top,25)
                    }
                    .zIndex(1)
                }
                    .ignoresSafeArea(.all)
            }
            else if leftPercent == 2/3 {
                GeometryReader{mainView in

                    ScrollView{

                        VStack(spacing: 0){

                            ForEach(self.result){tip in
                                if tip.tipClass == "Walk dog"{
                                GeometryReader{item in
                                    TipCellView(hight:80,content:tip.content)
                                        .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY),anchor: .bottom)

                                        .opacity(Double(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                                }
                                .frame(height:90)
                                }
                            }
                            Spacer()
                                .frame(height:25)
//                            Spacer()
//                                .frame(height:85)
                        }
                        .padding(.leading,10)
                        .padding(.top,25)
                    }
                    .zIndex(1)
                }
                    .ignoresSafeArea(.all)
            }
            else if leftPercent == 1 {
                GeometryReader{mainView in

                    ScrollView{

                        VStack(spacing: 0){

                            ForEach(self.result){tip in
                                if tip.tipClass == "Cycling"{
                                GeometryReader{item in
                                    TipCellView(hight:80,content:tip.content)
                                        .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY),anchor: .bottom)

                                        .opacity(Double(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                                }
                                .frame(height:90)
                                }
                            }
                            Spacer()
                                .frame(height:25)
//                            Spacer()
//                                .frame(height:85)
                        }
                        .padding(.leading,10)
                        .padding(.top,25)
                    }
                    .zIndex(1)
                }
                    .ignoresSafeArea(.all)
            }
        }
        .background(Color(.label).opacity(0.06).edgesIgnoringSafeArea(.all))
        
//        TabView{
//            ForEach(userData.safetyPolicy){ policy in
//                ScrollView{VStack{
////                    PolicyView(policy: policy)
////                        .padding(.horizontal)
//                    Spacer()
//                }}
//                .frame(height:UIScreen.main.bounds.height/2.5)
//            }
//        }.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode:.automatic))
//
//        .frame(height:UIScreen.main.bounds.height/2)
        //        Text(userData.safetyPolicy[1].content)
        //            .font(.body)
        //            .foregroundColor(Color(.label))
        //            .padding()
        //
        
    }
}

