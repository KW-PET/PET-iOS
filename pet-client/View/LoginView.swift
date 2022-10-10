import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

func getKakaoAgreement()->Bool { //회원가입 시 카카오톡으로 넘어가서 동의받는 부분
    var result: Bool = true
    if (UserApi.isKakaoTalkLoginAvailable()) {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            print("installed \(oauthToken?.accessToken)")
            print("installed \(error)")
            if(object_getClass(error)?.description() == "NSNull"){
                result = false
            }
        }
    }else{
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            print("non-installed \(oauthToken?.accessToken)")
            print("non-installed \(error)")
            if(object_getClass(error)?.description() == "NSNull"){
                result = false
            }
        }
    }
    return result
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
    var body: some View {
        Button(action : {
            var succeed = getKakaoAgreement()
            print(succeed)
        }){
            Image("KakaoLogin")
        }
        Button(action : getUserToken){
            Text("유저 토큰")
        }
        Button(action : disconnectWithKakao){
            Text("연결 끊기")
        }
        Button(action : getUserInfo){
            Text("유저 정보")
        }
    }
}
