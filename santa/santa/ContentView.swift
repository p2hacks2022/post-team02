//
//  ContentView.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI
import WebKit

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
    
    let url = "https://mebo.work/chat/bdc6523b-12a8-4e36-a042-f8934e869d6c185165b0e3c260?name=%E3%82%B5%E3%83%B3%E3%82%BF=%E3%82%B5%E3%83%B3&platform=webview"
    
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


struct AddCalendarEventView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                Color.xGreen
                    .ignoresSafeArea()
                VStack{
                    Text("MERRYでHAPPYでLUCKYな予定を")
                        .font(.custom("AB-hanamaki", size: 48))
                        .foregroundColor(Color.white)
                        .frame(width:241, height:351, alignment: .leading)
                        .lineSpacing(48)
                        .padding(.top, 50.0)
                        .padding(.bottom, 112.0)
                    
                    Text("カレンダーに追加する")
                        .font(.custom("AB-hanamaki", size: 20))
                        .frame(width: 294, height: 54)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(27)
                        .padding(.bottom, 154.0)
                    
                    //back to AskScedule
                    NavigationLink{
                        AskHaveScheduleView()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color.white)
                            Text("やっぱり予定があった！！")
                                .font(.custom("AB-hanamaki", size: 20))
                                .frame(width: 250, height: 20)
                                .foregroundColor(Color.white)
                                .padding(.trailing, 60.0)
                        }
                    }
                    
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct test: View {
    var body: some View {
        VStack {
            ChatViewControllerWrapper()
        }
    }
}

struct ChatViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ChatViewController {
            return ChatViewController()
        }
    
    func updateUIViewController(_ uiViewController: ChatViewController, context: Context) {
        
    }
}

//チャット画面の表示
class ChatViewController: UIViewController, WKScriptMessageHandler {
    private var webView: WKWebView!
    
    private let apiKey = "3720bd6f-56d9-4786-b864-063be074c5181851c28e31f1c3"
    private let uid = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        let userContentController: WKUserContentController = WKUserContentController()
        userContentController.add(self, name: "meboCallBack")
        config.userContentController = userContentController
        webView = WKWebView(frame: .zero, configuration: config)
        webView.load(URLRequest(url: URL(string: "https://mebo.work/chat/659c76cc-5363-47f2-9c6e-8b3950eab0471851c26062d9e?name=%E3%82%B5%E3%83%B3%E3%82%BF4&platform=webview")!))
        view = webView
    }

    //meboのチャット画面から送られてくる情報をハンドリング
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        struct ChatEvent: Codable {
            let event: String
            let bestResponse: BestResponse?
            let extensions: Extensions?
        }

        struct BestResponse: Codable {
            let utterance: String
            let options: [String]
        }

        struct Extensions: Codable {
            let appAction: String?
            let f_where: String?
            let s_time: String?
            let e_time: String?
            let nextwhere: String?
        }

        struct ChatError: Codable {
            let error: ChatErrorResponse
        }

        struct ChatErrorResponse: Codable {
            let code: Int
            let message: String
        }
        
        guard let json = (message.body as? String)?.data(using: .utf8) else {
                    return
                }
                let decoder = JSONDecoder()
                guard let chatEvent: ChatEvent = try? decoder.decode(ChatEvent.self, from: json) else {
                    if let error: ChatError = try? decoder.decode(ChatError.self, from: json) {
                        print(error.error.message)
                        return
                    }
                    fatalError("不明なエラー")
                }
        
        switch chatEvent.event {
            case "agentLoaded":
            webView.evaluateJavaScript("setAppInfo(\"\(apiKey)\",\"\(uid)\");")
                break
            case "agentResponded":
            
            if let str = chatEvent.extensions?.f_where {
                print(str)
            }
    
            if let str = chatEvent.extensions?.s_time {
                
                print(str)

//                let timeZone = TimeZone(abbreviation: "UTC")
//                let dateFormatter = DateFormatter()
//                var dateFormat = "yyyy/MM/dd HH-mm-ss"
//                dateFormatter.dateFormat = dateFormat
                
//                let dateFormatter = DateFormatter()
//                var dateFormat = "yyyy/MM/dd HH-mm-ss"
//                dateFormatter.dateFormat = dateFormat
//                // 日本標準時（地域名で指定）
//                dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                
                var dateFormatter = DateFormatter()
                
                // フォーマット設定
                dateFormatter.dateFormat = "yyyy/MM/dd HH-mm-ss"
                // ロケール設定（端末の暦設定に引きづられないようにする）
                dateFormatter.locale = Locale(identifier: "ja_JP")
                // タイムゾーン設定（端末設定によらず、どこの地域の時間帯なのかを指定する）
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                // 変換
                
                       if let date = dateFormatter.date(from: str)  {
                           print("Date(): ", date + 32400)
                       } else {
                           print("ERROR to convert")
                       }
                
                //print(str)
            }
            
            if let str = chatEvent.extensions?.e_time {
                
                print(str)
                let dateFormatter = DateFormatter()
                
                
                // フォーマット設定
                dateFormatter.dateFormat = "yyyy/MM/dd HH-mm-ss"
                // ロケール設定（端末の暦設定に引きづられないようにする）
                dateFormatter.locale = Locale(identifier: "ja_JP")
                // タイムゾーン設定（端末設定によらず、どこの地域の時間帯なのかを指定する）
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                // 変換
               
                
                if let date = dateFormatter.date(from: str) {
                            print("Dateend(): ", date + 32400)
                       } else {
                           print("ERROR to convert")
                       }
            }
            
            
            if let str = chatEvent.extensions?.nextwhere {
                print(str)
            }
            
            webView.evaluateJavaScript("setAppInfo(\"\(apiKey)\",\"\(uid)\");")
            
            
//            print(chatEvent.extensions?.appAction)
//            print(chatEvent.extensions?.f_where)
//            print(chatEvent.extensions?.s_time)
//            print(chatEvent.extensions?.e_time)
//            print(chatEvent.extensions?.nextwhere)
            
            
                break
            default:
                break
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

extension View {
    func customBackButton() -> some View {
        self.modifier(CustomBackButton())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //HomeView()
        // AskHaveScheduleView()
        // AskScheduleView()
        // AddCalendarEventView()
        // SelectSantaView()
        test()
    }
}
