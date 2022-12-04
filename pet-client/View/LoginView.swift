import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

@MainActor
func getKakaoAgreement() async -> Bool{ //회원가입 시 카카오톡으로 넘어가서 동의받는 부분
    @ObservedObject var loginManager = LoginManager()
    var result = false

    return await withCheckedContinuation { continuation in
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                loginManager.setJwtToken(accessToken: oauthToken?.accessToken ?? "")
                if((oauthToken?.accessToken) != nil){
                    result = true
                }
                continuation.resume(returning: result)
            }
        } else{
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                loginManager.setJwtToken(accessToken: oauthToken?.accessToken ?? "")
                if((oauthToken?.accessToken) != nil){
                    result = true
                }
                continuation.resume(returning: result)
            }
        }
    }
}

func getUserToken(){ //유저 토큰 얻어오기
    UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
        if let error = error {
            print(error)
        }
        else {
            print("accessTokenInfo() success: \(accessTokenInfo)")
        }
    }
}
    
func getUserInfo(){ //유저 정보 가져오기
    UserApi.shared.me() {(user, error) in
        if let error = error {
            print(error)
        }
        else {
            print("me() success: \(user)")
        }
    }
}
    
func disconnectWithKakao(){ //앱과 카카오계정 연결 끊기. 개발 테스트할 때, 혹은 탈퇴 시 사용
    UserApi.shared.unlink {(error) in
        if let error = error {
            print(error)
        }
        else {
            print("unlink() success.")
        }
    }
}
    
struct LoginView: View {
    @StateObject var viewModel = ContentVM()
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView{
            VStack{
                Image("LaunchingLogo")
                Spacer().frame(height: 200)
                Image("PetLogo")
                Spacer().frame(height: 150)
                Button(action : {
                    Task {
                        var result = await getKakaoAgreement()
                        if(result){
                            appState.refreshContentView()
                        }
                    }
                }){
                    Image("KakaoLogin")
                }
                Spacer()
            }
        }        
//            Button(action : getUserToken){
//                Text("유저 토큰")
//            }
//            Button(action : disconnectWithKakao){
//                Text("연결 끊기")
//            }
//            Button(action : getUserInfo){
//                Text("유저 정보")
//            }
    }
}
    
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
