//
//  ContentView.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI
import WebKit
import EventKitUI
import FirebaseFirestore
import AVFoundation


struct HomeView: View {
    let gifData_HomeView = NSDataAsset(name:"Home_back")?.data
    
    var body: some View {
        
        NavigationStack{
            NavigationLink{
                AskHaveScheduleView()
            } label: {
                
                ZStack{
                    VStack{
                        if let gifData = gifData_HomeView {
                                    GIFImage(data: gifData)
                                .ignoresSafeArea()
                                }
                        /*
                        Image("HomeView_back")
                            .ignoresSafeArea()
                         */
                    }
                }
            }
        }
    }
}

struct AskHaveScheduleView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.xGreen
                    .ignoresSafeArea()
                Image("light")
                    .padding(.bottom,749)
                    
                VStack {
                    Text("クリスマスに予定がありますか？")
                        .font(.custom("AB-hanamaki", size: 20))
                        .foregroundColor(Color.white)
                        .padding(.top, 90.0)
                        .padding(.bottom, 141.0)
                    
                    NavigationLink {
                        AskScheduleView()
                    } label: {
                        Text("ある！")
                            .font(.custom("AB-hanamaki", size: 20))
                            .frame(width: 294, height: 54)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(27)
                            .padding(.bottom, 35.0)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 7, y: 7)
                    }
                    
                    NavigationLink {
                        AddCalendarEventView()
                    } label: {
                        Text("ない...")
                            .font(.custom("AB-hanamaki", size: 20))
                            .frame(width: 294, height: 54)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(27)
                            .padding(.bottom, 84.0)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 7, y: 7)
                    }
                    
                    
                    Image("santa")
                        .padding(.leading, 50.0)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
    }
}

struct AskScheduleView: View {
    @StateObject var flagForHave = ChatViewController()
    
    init(){
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor.xGreen
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            NavigationLink(destination: HaveScheduleFinalView(), isActive: $flagForHave.flagForHave) {
                EmptyView()
            }
            ChatViewControllerWrapper()
            Button(action: {
                print($flagForHave.flagForHave)
            }, label: {
                Text("push")
                    .foregroundColor(Color.black)
            })
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color.white)
                            Text("サンタ＝サン")
                                .foregroundColor(Color.white)
                                .padding(.leading, 20.0)
                        }
                    }
                )
            }
        }
    }
}

struct MyWebView: UIViewRepresentable {
    
    let url: String
    private let observable = WebViewURLObservable()
    
    /// 監視する対象を指定して値の変化を検知する
    var observer: NSKeyValueObservation? {
        observable.instance
    }
    
    // MARK: - UIViewRepresentable
    /// 表示するViewのインスタンスを生成
    /// SwiftUIで使用するUIKitのViewを返す
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    // MARK: - UIViewRepresentable
    /// アプリの状態が更新される場合に呼ばる
    /// Viewの更新処理はこのメソッドに記述する
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        /// WKWebViewのURLが変わったこと（WebView内画面遷移）を検知して、URLをログ出力する
        observable.instance = uiView.observe(\WKWebView.url, options: .new) { view, change in
            if let url = view.url {
                print("Page URL: \(url)")
            }
        }
        
        /// URLを指定してWebページを読み込み
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}

// MARK:  WKWebViewのURLが変わったこと（WebView内画面遷移）を検知するための `ObservableObject`
private class WebViewURLObservable: ObservableObject {
    @Published var instance: NSKeyValueObservation?
}

struct AddCalendarEventView: View {
    @Environment(\.dismiss) var dismiss
    
    private let eventStore = EventStore()
    let calendar = Calendar(identifier: .gregorian)
    @State private var eventTitle = "test"
    @State private var startDate_timestamp = Timestamp()
    @State private var endDate_timestamp = Timestamp()
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var max = 0
    @State private var num = 0
    @State private var idx = 0
    @State private var flagForNotHave = false
    
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                Color.xGreen
                    .ignoresSafeArea()
                Image("AddCalendarEventView")
                    .ignoresSafeArea()
                Image("light")
                    .padding(.bottom,749)
                VStack {
                    NavigationLink(destination: NotHaveScheduleFinalView(), isActive: $flagForNotHave) {
                        EmptyView()
                    }
                    Button {
                        
                        Task {
                            await eventStore.requestAccess()
                            for i in 0...idx {
                                print(i)
                                Firestore.firestore().collection("schedules").document(String(num)).getDocument { (success, error) in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        let data = success!.data()
                                        eventTitle = data?["name" + String(i)] as? String ?? ""
                                        startDate_timestamp = data?["startDate" + String(i)] as! Timestamp
                                        endDate_timestamp = data?["endDate" + String(i)] as! Timestamp
                                        startDate = startDate_timestamp.dateValue()
                                        endDate = endDate_timestamp.dateValue()
                                        print(eventTitle)
                                        eventStore.addEvent(
                                            startDate: startDate,
                                            endDate: endDate,
                                            title: eventTitle
                                        )
                                    }
                                }
                            }
                            flagForNotHave = true
                        }
                        
                    } label: {
                        Text("カレンダーに追加する")
                            .font(.custom("AB-hanamaki", size: 20))
                            .frame(width: 294, height: 54)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(27)
                            .padding(.top, 500.0)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 7, y: 7)
                    }
                }
                .task {
                    Firestore.firestore().collection("schedules").document("cntSet").getDocument { (success, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            let data = success!.data()
                            max = data?["cnt"] as! Int
                            num = Int.random(in: 0..<max)
                            print("num: " + String(num))
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        print("String(num): " + String(num))
                        Firestore.firestore().collection("schedules").document(String(num)).getDocument { (success, error) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                let data = success!.data()
//                                eventTitle = data?["name0"] as? String ?? ""
//                                startDate_timestamp = data?["startDate0"] as! Timestamp
//                                endDate_timestamp = data?["endDate0"] as! Timestamp
//                                startDate = startDate_timestamp.dateValue()
//                                endDate = endDate_timestamp.dateValue()
                                idx = data?["num"] as! Int
                                
//                                print(eventTitle)
//                                print(startDate)
//                                print(endDate)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.white)
                                Text("やっぱり予定があった！！")
                                    .font(.custom("AB-hanamaki", size: 20))
                                    .frame(width: 250, height: 20)
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 60.0)
                            }
                        }
                    )
                    Spacer()
                }
            }
        }
    }
}

struct HaveScheduleFinalView: View {
    let gifData_HaveScheduleFinalView = NSDataAsset(name:"HaveScheduleFinalView")?.data
    var body: some View {
        ZStack{
            VStack{
                if let gifData = gifData_HaveScheduleFinalView {
                    GIFImage(data: gifData)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct NotHaveScheduleFinalView: View {
    let gifData_NotHaveScheduleFinalView = NSDataAsset(name:"NotHaveScheduleFinalView")?.data
    var body: some View {
        ZStack{
            VStack{
                if let gifData = gifData_NotHaveScheduleFinalView {
                    GIFImage(data: gifData)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct CustomBackButton: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color.white)
                        }
                    )
                    Spacer()
                }
            }
    }
}

struct Test: View {
    var body: some View {
        ChatViewControllerWrapper()
    }
}

extension View {
    func customBackButton() -> some View {
        self.modifier(CustomBackButton())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //HomeView()
        //AskHaveScheduleView()
        AskScheduleView()
        //AddCalendarEventView()
        //HaveScheduleFinalView()
        //NotHaveScheduleFinalView()
        //SelectSantaView()
        //Test()
    }
}
