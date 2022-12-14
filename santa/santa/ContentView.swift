//
//  ContentView.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI
import FirebaseFirestore

let db = Firestore.firestore()

struct ContentView: View {
    @State private var name = ""
    @State private var retName = ""
    var body: some View {
        VStack {
            Text(name)
            TextField("input text", text: $name)
            .frame(width: UIScreen.main.bounds.width * 0.95)
            Button(action: {
                Firestore.firestore().collection("users").document("user002").setData(["name": name])
            }, label: {
                Text("push to write")
            })
            Text(retName)
                .padding()
            Button(action: {
                Firestore.firestore().collection("users").document("user002").getDocument { (success, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        let data = success!.data()
                        retName = success!.data()?["name"] as? String ?? ""
                        print(data!)
                    }
                }
            }, label: {
                Text("push to read")
            })
            Button(action: {
                print("debug")
            }, label: {
                Text("push to debug")
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
