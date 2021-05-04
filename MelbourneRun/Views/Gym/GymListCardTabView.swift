//
//  GymListCardTabView.swift
//  MelbExercise
//
//  Created by gaoyu shi on 3/5/21.
//

import SwiftUI
import CoreData
import Combine

struct GymListCardTabView<T: NSManagedObject,Content: View>: View {
//    @EnvironmentObject var userData:UserData
//    @State var selectedGymIndex:Int
    @Binding var selectedGymUid:Int
    let detector: CurrentValueSubject<CGFloat, Never>
    let publisher: AnyPublisher<CGFloat, Never>
    @EnvironmentObject var userData:UserData
    @Binding var gotTap:Bool
    @Binding var isSearching:String
    var fetchRequest: FetchRequest<T>
//    @Binding var selectedGymClass:String
    var gyms:FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    let content:(T) -> Content
    
    private func findIndexOfGym(gym:T) -> Int?{
        var index:Int = 0
        for i in gyms{
            if (gym as! GymCore).uid == (i as! GymCore).uid{
                return index
            }
            index += 1
        }
        return nil
    }
    init(classType:String,search:String,selectedGymUid:Binding<Int>, gotTap:Binding<Bool>,isSearching:Binding<String>,@ViewBuilder content:@escaping (T) -> Content) {
//        selectedGymClass = classType
//        selectedGymIndex = 0
        self._selectedGymUid = selectedGymUid
//        self._selectedGymIndex = State(initialValue: 0)
        self._gotTap = gotTap
        self._isSearching = isSearching
        if classType == "No membership"{
            if search == ""
            {fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)])}
            else if search.caseInsensitiveCompare("star") == .orderedSame{
                fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "star == %i", true))
            }
            else{
                fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "name CONTAINS[c] %@ OR address CONTAINS[c] %@ OR classType CONTAINS[c] %@", search,search,search))
            }
        }
        else {
            if search == ""{
                fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@", classType))
            }
            else if search.caseInsensitiveCompare("star") == .orderedSame{
                fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@ AND star == %i", classType, true))
            }
            else{fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \GymCore.distance, ascending: true)], predicate: NSPredicate(format: "classType == %@ AND (name CONTAINS[c] %@ OR address CONTAINS[c] %@ OR classType CONTAINS[c] %@)", classType, search,search,search))}
            
        }
        
        self.content = content
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
                    .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
                    .dropFirst()
                    .eraseToAnyPublisher()
        self.detector = detector
    }
//    private func findIndexOfGym(gym:GymCore) -> Int?{
//        var index:Int = 0
//        for i in result{
//            if gym.uid == i.uid{
//                return index
//            }
//            index += 1
//        }
//        return nil
//    }
    var body: some View {
        
        ScrollViewReader{ value in
            ScrollView(.horizontal, showsIndicators: false)
        {
            ZStack{
                LazyHStack{
                ForEach(self.fetchRequest.wrappedValue,id:\.self){gym in
    //                        if gym.classType == userData.hasMemberShip || userData.hasMemberShip == "No membership"{
                    self.content(gym)
                        .id(Int((gym as! GymCore).uid))
                }
            }.padding(.horizontal,18)
                GeometryReader { proxy in
                                        let offset = proxy.frame(in: .named("scroll")).minX//may need change
                                        Color.clear.preference(key: ViewOffsetKey.self, value: offset)
                                    }
            }
            }.onChange(of:gotTap,perform:{ num in
//                withAnimation(.easeInOut(duration:1)){
                DispatchQueue.main.async{
                    withAnimation(.easeInOut(duration:1)){value.scrollTo(selectedGymUid,anchor:.center)}
                }
//                }
            })
            .onChange(of:selectedGymUid,perform:{ _ in
//                withAnimation(.easeInOut(duration:1)){
                DispatchQueue.main.async{
                    withAnimation(.easeInOut(duration:1)){value.scrollTo(selectedGymUid,anchor:.center)}
                }
//                }
            })
         
            
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ViewOffsetKey.self) { value in
            detector.send(value)
//            self.selectedGymIndex = Int(-(value-348.5/2)/348.5)
        }
        .onReceive(publisher) { value in
            DispatchQueue.main.async{ self.selectedGymUid = Int((gyms[Int(-(value-348.5/2)/348.5)] as! GymCore).uid)}
        }
        
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3 + 20, alignment: .center)
//        .onChange(of: selectedGymIndex, perform: { value in
//            DispatchQueue.main.async{ self.selectedGymUid = Int((gyms[value] as! GymCore).uid)}
////            print(selectedGymUid.description)
//        })
        .background(Color(.clear))
        .onChange(of: userData.hasMemberShip, perform: { value in
            print("change membership")
            DispatchQueue.main.async{ self.selectedGymUid = Int((gyms[0] as! GymCore).uid)} //may need change
//            print(selectedGymUid.description)
        })
        .onChange(of: isSearching, perform:{value in
            if fetchRequest.wrappedValue.isEmpty{
            }
            else{
                DispatchQueue.main.async{
                    self.selectedGymUid = Int((gyms[0] as! GymCore).uid)
                }
            }
        })
//        ScrollView{
//            HStack{
//                TabView{
//                    ForEach(self.fetchRequest.wrappedValue,id:\.self){
//                    gym in
//                    self.content(gym)
//                }
//                }.tabViewStyle(PageTabViewStyle())
//            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.38, alignment: .center)
//        }
    }
}
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
