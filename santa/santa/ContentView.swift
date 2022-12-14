//
//  ContentView.swift
//  santa
//
//  Created by enPiT2016MBP-04 on 2022/12/11.
//

import SwiftUI
import WebKit

struct ContentView: View {
    let url = "https://mebo.work/chat/d090d0c9-36b9-496f-b173-5e7aedd5018718506afa89a1eb?name=%E3%82%B5%E3%83%B3%E3%82%BF"
    var body: some View {
        ZStack {
            MyWebView(url: "https://google.com")
                .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ViewController: UIViewController, WKScriptMessageHandler {
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        let userContentController: WKUserContentController = WKUserContentController()
        userContentController.add(self, name: "meboCallBack")
        config.userContentController = userContentController
        webView = WKWebView(frame: .zero, configuration: config)
        webView.load(URLRequest(url: URL(string: "https://mebo-admin.work/admin/preview/d090d0c9-36b9-496f-b173-5e7aedd5018718506afa89a1eb&platform=webview")!))
        view = webView
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // TODO: Impl
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
