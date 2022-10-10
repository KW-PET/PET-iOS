import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

struct ContentView: View {
    var body: some View {
        Button(action : {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    print("installed \(oauthToken?.accessToken)")
                    print("installed \(error)")
                }
            }else{
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    print("non-installed \(oauthToken?.accessToken)")
                    print("non-installed \(error)")
                }
            }
        }){
            
            Text("카카오 로그인")
        }       
    }
}
 
