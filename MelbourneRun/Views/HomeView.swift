//
//  HomeView.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 25/3/21.
//

import SwiftUI
import SDWebImageSwiftUI
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
    
    @State var viewState = CGSize.zero
    @State var isDetectingLongPress = false
    @State var isSelected = false
    
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

    
    //MARK: View Body
    var body: some View {
        
        VStack{
            GeometryReader { geometry in
            ZStack {
                VStack {
                    TopView(isSelected: self.$isSelected)
                        .environmentObject(userData)
                        .frame(height: self.normalCardHeight)
                    
                    if self.isSelected {
                        ExpandableView(isSelected: self.$isSelected)
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
                    self.userData.getSlogan()
                    self.userData.getSafeTips()}, label: {
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
    }

}


//MARK: TopView
struct TopView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isSelected: Bool
    

    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    WebImage(url: URL(string: NetworkManager.shared.urlBasePath + userData.image))
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
                            .frame(height: 65)
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
                        VStack(alignment: .leading) {
                        }
                        
                        Spacer()
                        
                        if self.isSelected {
                            Button(action: {
                                withAnimation(Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)) {
                                    self.isSelected = false
                                     }}) {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(Color(.label))
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
                        Text(userData.slogan)
                            .foregroundColor(Color(.label))
                            .font(.caption)
                            .lineLimit(3)
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
    
    @EnvironmentObject var userData:UserData
    
    
    var body: some View {
        Text(userData.safeTips)
            .font(.body)
            .foregroundColor(Color(.label))
            .padding()
    }
}

struct HomeView: View {
    @EnvironmentObject var userData:UserData
    
    var body: some View {
 
            ExpandableCardView()
                .environmentObject(userData)
            
        .offset(y:-UIScreen.main.bounds.height/15)
        .onAppear(perform: {
            self.userData.getPosterName()
            self.userData.getSlogan()
            self.userData.getSafeTips()
            self.userData.getWeatherDataNow()
        })
        
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserData())
        
    }
}
