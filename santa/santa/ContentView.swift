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

struct HomeView: View {
    var body: some View {
        NavigationStack{
            NavigationLink{
                AskHaveScheduleView()
            } label: {
                ZStack{
                    VStack{
                        Image("HomeView_back")
                            .ignoresSafeArea()
                    }
                    
                    Text("TAP to TALK")
                        .font(.custom("AB-hanamaki", size: 15))
                        .foregroundColor(Color.white)
                        .padding(.top, 700)
                    //.position(x: 137+115/2, y: 767)
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
    
    let url = "https://mebo.work/chat/d090d0c9-36b9-496f-b173-5e7aedd5018718506afa89a1eb?name=%E3%82%B5%E3%83%B3%E3%82%BF"
    
    var body: some View {
        ZStack {
            MyWebView(url: url)
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


//struct SelectSantaView: View {
//
//    @Environment(\.dismiss) var dismiss
//
//    init() {
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = UIColor.red
//    }
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.xGreen
//                    .ignoresSafeArea()
//                Text("話を聞いてもらうサンタを選ぶ")
//                    .foregroundColor(Color.white)
//                    .frame(width: 395, height: 120)
//                    .padding(.top, 30.0)
//                    .background(Color.xRed)
//                    .cornerRadius(20)
//                    .padding(.bottom, 680.0)
//                    .font(.system(size: 20))
//                VStack {
//                    HStack {
//                        Circle()
//                            .strokeBorder(Color.black)
//                            .frame(width: 54, height: 54)
//
//                        VStack(alignment: .leading) {
//                            Text("サンタ＝サン")
//                                .fontWeight(.black)
//                                .font(.system(size: 15))
//                            Text("日本のクリスマスをずっと見てきた。ゆったり話を聞いてくれます。")
//                                .font(.system(size: 13))
//                        }
//
//                    }
//                    .frame(width: 290.0, height: 54.0)
//                    .padding(.horizontal, 18.0)
//                    .padding(.vertical, 16.0)
//                    .background(Color.white)
//                    .cornerRadius(15)
//                    .padding(.bottom, 100.0)
//
//                    HStack {
//                        Circle()
//                            .strokeBorder(Color.black)
//                            .frame(width: 54, height: 54)
//
//                        VStack(alignment: .leading) {
//                            Text("サンタ＝マン")
//                                .fontWeight(.black)
//                                .font(.system(size: 15))
//                            Text("アメリカ生まれのアメリカ育ち。ファンキーに話を聞いてくれます。")
//                                .font(.system(size: 13))
//                        }
//                    }
//                    .frame(width: 290.0, height: 54.0)
//                    .padding(.horizontal, 18.0)
//                    .padding(.vertical, 16.0)
//                    .background(Color.white)
//                    .cornerRadius(15)
//                    .padding(.bottom, 100.0)
//
//                    HStack {
//                        Circle()
//                            .strokeBorder(Color.black)
//                            .frame(width: 54, height: 54)
//
//                        VStack(alignment: .leading) {
//                            Text("サンタ＝イエア")
//                                .fontWeight(.black)
//                                .font(.system(size: 15))
//
//                            Text("世界中を飛び回っている。感情豊かに話を聞いてくれます")
//                                .font(.system(size: 13))
//                        }
//                    }
//                    .frame(width: 290.0, height: 54.0)
//                    .padding(.horizontal, 18.0)
//                    .padding(.vertical, 16.0)
//                    .background(Color.white)
//                    .cornerRadius(15)
//                }
//                .padding(.top, 60.0)
//            }
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItemGroup(placement: .bottomBar) {
//                    Button(
//                        action: {
//                            dismiss()
//                        }, label: {
//                            HStack {
//                                Image(systemName: "chevron.backward")
//                                    .foregroundColor(Color.white)
//                                Text("本当は予定がなかった…")
//                                    .foregroundColor(Color.white)
//                            }
//                        }
//                    )
//                    Spacer()
//                }
//            }
//        }
//    }
//}


struct AddCalendarEventView: View {
    @Environment(\.dismiss) var dismiss
    
    private let eventStore = EventStore()
    let calendar = Calendar(identifier: .gregorian)
    @State private var eventTitle = "test"
    @State private var startDate_timestamp = Timestamp()
    @State private var endDate_timestamp = Timestamp()
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.xGreen
                    .ignoresSafeArea()
                VStack {
                    Text("MERRYでHAPPYでLUCKYな予定を")
                        .font(.custom("AB-hanamaki", size: 48))
                        .foregroundColor(Color.white)
                        .frame(width:241, height:351, alignment: .leading)
                        .lineSpacing(48)
                        .padding(.top, 50.0)
                        .padding(.bottom, 112.0)
                    
                    Button {
                        Task {
                            await eventStore.requestAccess()
                            await eventStore.addEvent(
                                startDate: startDate,
                                endDate: endDate,
                                title: eventTitle
                            )
                        }
                    } label: {
                        Text("カレンダーに追加する")
                            .font(.custom("AB-hanamaki", size: 20))
                            .frame(width: 294, height: 54)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .cornerRadius(27)
                            .padding(.bottom, 154.0)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 7, y: 7)
                    }
                }
                .task {
                    Firestore.firestore().collection("schedules").document("1").getDocument { (success, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            let data = success!.data()
                            eventTitle = data?["name"] as? String ?? ""
                            startDate_timestamp = data?["startDate"] as! Timestamp
                            endDate_timestamp = data?["endDate"] as! Timestamp
                            startDate = startDate_timestamp.dateValue()
                            endDate = endDate_timestamp.dateValue()
                            
                            print(eventTitle)
                            print(startDate)
                            print(endDate)
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
    @State private var str = ""
    var body: some View {
        VStack {
            Text(str)
            Button(action: {
                Firestore.firestore().collection("schedules").document("1").getDocument { (success, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        let data = success!.data()
                        str = success!.data()?["name"] as? String ?? ""
                        print(data!)
                    }
                }
            }, label: {
                Text("push")
            })
        }
    }
}

extension View {
    func customBackButton() -> some View {
        self.modifier(CustomBackButton())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        // AskHaveScheduleView()
        // AskScheduleView()
        // AddCalendarEventView()
        // SelectSantaView()
        // Test()
    }
}
