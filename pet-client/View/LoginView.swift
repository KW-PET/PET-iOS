import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

@MainActor
func getKakaoAgreement() async -> String { //회원가입 시 카카오톡으로 넘어가서 동의받는 부분
    @ObservedObject var loginManager = LoginManager()

    if (UserApi.isKakaoTalkLoginAvailable()) {
        return await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                continuation.resume(returning: oauthToken?.accessToken ?? "")
            }
        }
    } else {
        return await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                continuation.resume(returning: oauthToken?.accessToken ?? "")
            }
        }
    }
}

@MainActor
func checkIfNicknameNeeded(accessToken: String) {
    @ObservedObject var loginManager = LoginManager()
    @ObservedObject var userManager = UserManager()
    
    Task {
        let jwtToken = try await loginManager.getJwtToken(accessToken: accessToken)
        UserDefaults.standard.set(jwtToken.data, forKey: "jwtToken")
        let userInfo = try await userManager.getUserInfo()
        if(userInfo.data?.nickname != "" && userInfo.data?.nickname != nil) {
            UserDefaults.standard.set(userInfo.data?.nickname, forKey: "nickname")
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
    @ObservedObject var loginManager = LoginManager()

    var body: some View {
        NavigationView{
            VStack{
                Image("LaunchingLogo")
                Spacer().frame(height: 200)
                Image("PetLogo")
                Spacer().frame(height: 150)
                Button(action : {
                    Task {
                        let result = await getKakaoAgreement()
                        if (result != "") {
                            checkIfNicknameNeeded(accessToken: result)
                            appState.refreshContentView()
                        }
                    }
                }){
                    Image("KakaoLogin")
                }
                Spacer()
            }
        }
    }
}

struct NicknameSetupView: View {
    @StateObject var viewModel = ContentVM()
    @EnvironmentObject var appState: AppState
    @State var nickname: String = ""
    @ObservedObject var loginManager = LoginManager()

    var body: some View {
        NavigationView{
            VStack{
                Image("LaunchingLogo")
                Spacer().frame(height: 200)
                Button(action: {
                    appState.refreshContentView()
                    UserDefaults.standard.removeObject(forKey: "jwtToken")
                    UserDefaults.standard.removeObject(forKey: "nickname")
                }) {
                    Text("토큰 지우기")
                }
                VStack{
                    TextField("닉네임을 입력하세요", text: $nickname)
                        .padding(15)
                        .background(Color(.white))
                        .cornerRadius(15)
                        .shadow(color: ColorManager.OrangeColor, radius: 2)
                        .submitLabel(.done)
                    
                    Spacer().frame(height: 150)
                    
                    Button(action: {
                        Task {
                            let result = try await loginManager.updateNickname(nickname: nickname)
                            if(result.status == 200) {
                                UserDefaults.standard.set(nickname, forKey: "nickname")
                                appState.refreshContentView()
                            }
                        }
                    }, label:{
                        Text("설정 완료")
                            .font(.system(size: 15).weight(.medium))
                            .foregroundColor(Color.white)
                            .frame(maxWidth:.infinity)
                    })
                    .padding(.vertical, 15)
                    .padding(.horizontal, 7)
                    .frame(maxWidth:.infinity)
                    .background(ColorManager.OrangeColor)
                    .cornerRadius(30)
                }.padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}
