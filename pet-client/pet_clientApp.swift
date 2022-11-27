import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main

struct pet_clientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var loginManager = LoginManager()

    var body: some Scene {
        WindowGroup {
            if loginManager.authCheck() == true {
                MainView()
            } else {
                LoginView().onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
            }
        }
    }
}
