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
    var body: some View {
        ZStack{
//            RoundedRectangle(cornerRadius: 15)
//                .fill(Color(.systemGray5).opacity(0.7))
//                .frame(width: 80, height: UIScreen.main.bounds.height/5, alignment: .center)
            VisualEffectView(effect: UIBlurEffect(style: .light))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 60, height: UIScreen.main.bounds.height/5, alignment: .center)
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
            .frame(width:50)
        }
    }
}

struct RiskLabelView_Previews: PreviewProvider {
    static var previews: some View {
        RiskLabelView()
    }
}
