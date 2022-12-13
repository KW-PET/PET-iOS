//
//  MypageView.swift
//  pet-client
//
//  Created by 박수연 on 2022/11/14.
//

import Foundation
import SwiftUI
import PhotosUI

public struct Pet: Hashable{
    let petid: Int
    let petname: String
    let pic: String
    let sort: String
    let age: Int
    let count: Int
 }


struct Profile: View {
    var pet: PetModel

    var body: some View {
        VStack{
            if((pet.pic) != nil && pet.pic != ""){
                AsyncImage(url: URL(string: pet.pic!.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)! ,
                           content:
                    { image in  image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 230, height: 230)
                        },
                           placeholder:{
                    Text("loading")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                })

                    .frame(width: 230, height: 230)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    .padding(5)
            }
            else{
                Image("DefaultProfile")
                    .background(Color.cyan.opacity(0.5))
                    .frame(width: 230, height: 230)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(5)
            }

            HStack{
                Text(pet.name+"와 만난지")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                
                Text("\(Date().calculateDays(created_at: pet.start_date))")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.pink)
                
                Text("일")
                    .font(.system(size: 21).weight(.bold))
                    .foregroundColor(Color.black)
            }
            .padding(.horizontal,16)
            .padding(.top,15)
            
            Text(pet.sort+"  /  "+String(pet.age)+" 세")
                .font(.system(size: 16).weight(.medium))
                .foregroundColor(Color.black)
                .padding(.vertical,2)

        }
        .frame(width:280, height:365)
     }
}


struct LabelTextField : View {
    var label: String
    @Binding var text: String
    
    var body: some View {
        HStack() {
            Text(label)
                .font(.system(size: 15).weight(.bold))
                .foregroundColor(Color.black)
             Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.1))
                HStack {
                    TextField("", text: $text)
                        .padding(.leading,10)
                        .font(.system(size: 14))
                }
                .foregroundColor(Color.black)
             }
            .frame(width:200, height: 35)
            .cornerRadius(13)
         }
    }
}

struct MypageContentView : View {
    @Binding var newPetData : newPetModel
    @State var petname: String = ""
    @State var sort: String = ""
    @State var age : String = ""
    @State var count : Date = Date()
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
       
    var body: some View {
        VStack{
            VStack{
              
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                            
                                .resizable()
                                .frame(width: 150, height: 150)
                                .scaledToFit()
                            
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                                .padding(.bottom,22)
                        }
                        else{
                            Image("DefaultProfile")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .padding(30)
                                .background(Color.gray.opacity(0.05))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                                .padding(.bottom,25)
                        }
                        
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                                newPetData.file = data
                            }
                        }
                    }
                
            }
            
            VStack(alignment: .center) {
                LabelTextField(label: "이름",text: $newPetData.name)
                LabelTextField(label: "종",text: $newPetData.sort)
                LabelTextField(label: "나이",text: $newPetData.age)
                HStack(){
                    Text("만난 날")
                        .font(.system(size: 15).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                    DatePicker("", selection: $newPetData.start_date, displayedComponents: .date)
                        .frame(width: 200)
                        .padding(4)
                        .labelsHidden()
                        .datePickerStyle(.automatic)
                }
                
            }
            
        }.frame(width:270, height:365)
        
    }

    
}

struct ScrollPetView : View{
    @Binding var petData : [PetModel]
    
    var body: some View{
        HStack(alignment: .center) {
            ForEach(0..<petData.count, id: \.self) { i in
                Profile(pet: petData[i])
            }
        }
        .modifier(ScrollingHStackModifier(items: petData.count, itemWidth: 280, itemSpacing: 10))
    
    }
}

struct MyInfoView : View{
    @State var selectedId:Int = 1
    @State var isEdit:Bool = false
    @State var userData: UserModel = UserModel(created_at: [], modified_at: [], userId:0 , uuid: "", name: "", nickname: "", email: "", token: "")
    @State var petData: [PetModel] = []
    @State var loading:Bool = true
    @State var newPetData: newPetModel = newPetModel(file: nil, name: "", age: "", start_date: Date(), sort: "")
    @EnvironmentObject var appState: AppState
    
    var body: some View{
        VStack{
            HStack{
                Text("마이페이지")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 28)
            
            VStack {
            }
            .frame(width: 1000, height:4)
            .background(Color.gray.opacity(0.2))
            .border(Color.gray.opacity(0.3))
            
            HStack{
                Text(userData.nickname)
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                Text("님 반갑습니다!")
                    .font(.system(size: 18).weight(.bold))
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 28)
            
            Divider()
            
            HStack{
                Image("MypetIcon")
                    .resizable()
                    .frame(width: 25, height: 25)
                
                Text("나의 PET !")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
                    .padding(.horizontal,4)
                Spacer()
                
                if(!isEdit){
                    
                    Button(action: {
                        isEdit = true
                    }){
                        Text("추가")
                            .font(.system(size: 15).weight(.medium))
                            .foregroundColor(ColorManager.GreyColor)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 16)
                            .cornerRadius(50)
                            .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(Color.gray.opacity(0.2)))
                            .padding(.horizontal, 10)
                    }
                    
                }
                else {
                    Button(action: {
                        Task{
                            let res = try await UserManager().postPet(newPetData : newPetData)
                            if(res.success ?? false){
                                let res_ = try await UserManager().getPetInfo()
                                petData = res_.data!
                                newPetData = newPetModel(file: nil, name: "", age: "", start_date: Date(), sort: "")
                            }
                        }
                        isEdit = false
                    }){
                        
                        Text("완료")
                            .font(.system(size: 15).weight(.medium))
                            .foregroundColor(ColorManager.GreyColor)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 16)
                            .cornerRadius(50)
                            .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(Color.gray.opacity(0.2)))
                            .padding(.horizontal, 10)
                    }
                }
                
                
                
            }
            .padding(.top, 14)
            .padding(.horizontal, 28)
            
            if(loading)
            {
                VStack{}
        .frame(width:270, height:365)

            }
            else{
                if(petData.count == 0 || isEdit ){
                    MypageContentView(newPetData: $newPetData)
                }
                else {
                    ScrollPetView(petData: $petData)
                }
            }
            
            VStack {
            }
            .frame(width: 1000, height:5)
            .background(Color.gray.opacity(0.2))
            .border(Color.gray.opacity(0.3))
            
            VStack(alignment: .center){
                
                NavigationLink(destination: MyPostView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                ){
                    Text("내가 쓴 글")
                        .font(.system(size: 17).weight(.bold))
                        .padding(.vertical, 5)
                        .foregroundColor(Color.black)
                }
                Divider()
                
                NavigationLink(destination: MyLikeView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                ){
                    Text("찜한 매장")
                        .font(.system(size: 17).weight(.bold))
                        .padding(.vertical, 5)
                        .foregroundColor(Color.black)
                }
                Divider()
                
                
                Button(action: {
                    UserDefaults.standard.removeObject(forKey: "jwtToken")
                    UserDefaults.standard.removeObject(forKey: "nickname")
                    appState.refreshContentView()
                }) {
                    Text("로그아웃")
                        .frame(maxWidth: .infinity)
                }
                .font(.system(size: 17).weight(.bold))
                .padding(.vertical, 5)
                .foregroundColor(Color.black)
                
            }
            VStack {
            }
            .frame(width: 1000, height:4)
            .background(Color.gray.opacity(0.2))
            .border(Color.gray.opacity(0.3))
        }
        
        .onAppear{
            Task{
                let res = try await UserManager().getUserInfo()
                userData = res.data!
                
                let res_ = try await UserManager().getPetInfo()
                petData = res_.data ?? []
                loading = false
            }
            
        }
        
    }
}
struct MypageView: View{
    var body: some View{
        NavigationView{
                MyInfoView()
            }
        }
    
}


struct ScrollingHStackModifier: ViewModifier {

    @State private var scrollOffset: CGFloat
    @State private var dragOffset: CGFloat

    var items: Int
    var itemWidth: CGFloat
    var itemSpacing: CGFloat

    init(items: Int, itemWidth: CGFloat, itemSpacing: CGFloat) {
        self.items = items
        self.itemWidth = itemWidth
        self.itemSpacing = itemSpacing

        // Calculate Total Content Width
        let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
        let screenWidth = UIScreen.main.bounds.width

        // Set Initial Offset to first Item
        let initialOffset = (contentWidth/2.0) - (screenWidth/2.0) + ((screenWidth - itemWidth) / 2.0)

        self._scrollOffset = State(initialValue: initialOffset)
        self._dragOffset = State(initialValue: 0)
    }

    func body(content: Content) -> some View {
        content
            .offset(x: scrollOffset + dragOffset, y: 0)
            .gesture(DragGesture()
                .onChanged({ event in
                    dragOffset = event.translation.width
                })
                .onEnded({ event in
                    // Scroll to where user dragged
                    scrollOffset += event.translation.width
                    dragOffset = 0

                    // Now calculate which item to snap to
                    let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
                    let screenWidth = UIScreen.main.bounds.width

                    // Center position of current offset
                    let center = scrollOffset + (screenWidth / 2.0) + (contentWidth / 2.0)

                    // Calculate which item we are closest to using the defined size
                    var index = (center - (screenWidth / 2.0)) / (itemWidth + itemSpacing)

                    // Should we stay at current index or are we closer to the next item...
                    if index.remainder(dividingBy: 1) > 0.5 {
                        index += 1
                    } else {
                        index = CGFloat(Int(index))
                    }

                    // Protect from scrolling out of bounds
                    index = min(index, CGFloat(items) - 1)
                    index = max(index, 0)

                    // Set final offset (snapping to item)
                    let newOffset = index * itemWidth + (index - 1) * itemSpacing - (contentWidth / 2.0) + (screenWidth / 2.0) - ((screenWidth - itemWidth) / 2.0) + itemSpacing

                    // Animate snapping
                    withAnimation {
                        scrollOffset = newOffset
                    }

                })
            )
    }
}


struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}
