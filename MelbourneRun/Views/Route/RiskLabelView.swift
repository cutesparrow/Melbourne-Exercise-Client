//
//  RiskLabelView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 11/4/21.
//

import SwiftUI
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
struct RiskLabelView: View {
    @Binding var expand:Bool
    var body: some View {
        ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: expand ? UIScreen.main.bounds.width-40 : 60, height: UIScreen.main.bounds.height/5, alignment: .center)
                .shadow(radius: 10)
            if !expand{
                VStack{
                Text("Risk")
                    .font(.caption)
                    .bold()
                    .padding(.bottom)
                    
                HStack{
                    Text("No")
                        .font(.caption)
                    Spacer()
                    Circle()
                        .fill(AppColor.shared.noRiskColor)
                        .frame(width: 10, height: 10, alignment: .center)
                }
                HStack{
                    Text("Low")
                        .font(.caption)
                    Spacer()
                    Circle()
                        .fill(AppColor.shared.lowRiskColor)
                        .frame(width: 10, height: 10, alignment: .center)
                }
                HStack{
                    Text("Mid")
                        .font(.caption)
                    Spacer()
                    Circle()
                        .fill(AppColor.shared.midRiskColor)
                        .frame(width: 10, height: 10, alignment: .center)
                }
                HStack{
                    Text("High")
                        .font(.caption)
                    Spacer()
                    Circle()
                        .fill(AppColor.shared.highRiskColor)
                        .frame(width: 10, height: 10, alignment: .center)
                }
        }
            .frame(width:50)}
            else {
                VStack(alignment:.leading){
                    HStack{
                        Circle()
                            .fill(AppColor.shared.noRiskColor)
                            .frame(width: 10, height: 10, alignment: .center)
                        Text("No - less than 5 pedestrians per minute")
                            .font(.system(size: 14))
                    }.padding(.bottom,-2)
                    HStack{
                        Circle()
                            .fill(AppColor.shared.lowRiskColor)
                            .frame(width: 10, height: 10, alignment: .center)
                        Text("Low - 5 to 10 pedestrians per minute")
                            .font(.system(size: 14))
                    }.padding(.vertical,-2)
                    HStack{
                        Circle()
                            .fill(AppColor.shared.midRiskColor)
                            .frame(width: 10, height: 10, alignment: .center)
                        Text("Medium - 10 to 20 pedestrians per minute")
                            .font(.system(size: 14))
                    }.padding(.vertical,-2)
                    HStack{
                        Circle()
                            .fill(AppColor.shared.highRiskColor)
                            .frame(width: 10, height: 10, alignment: .center)
                        Text("High - more than 20 pedestrians per minute")
                            .font(.system(size: 14))
                    }.padding(.vertical,-2)
                    Text("Please try to workout outdoors when there are more green spots on the map.")
                        .font(.system(size: 14))
                        
                }
         
                    .padding()
                    .frame(width:UIScreen.main.bounds.width-40,height:UIScreen.main.bounds.height/5)
            }
        }.onTapGesture {
            withAnimation{self.expand.toggle()}
        }
    }
}

//struct RiskLabelView_Previews: PreviewProvider {
//    static var previews: some View {
//        RiskLabelView()
//    }
//}
