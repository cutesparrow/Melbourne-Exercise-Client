//
//  testview.swift
//  MelbourneRun
//
//  Created by gaoyu shi on 31/3/21.
//

import SwiftUI


struct User: Identifiable {
    let id = UUID()
    let username: String
}
struct testview: View {
    let a:[User] = [User(username: "a"),User(username: "b"),User(username: "c")]
    var body: some View {
        List{
            ForEach(a){ i in
                if i.username != "b"{
                    Text(i.username)
                }
                
                
            }
        }
    }
}

struct testview_Previews: PreviewProvider {
    static var previews: some View {
        testview()
    }
}
