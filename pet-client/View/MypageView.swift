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
    var pet: Pet
    var body: some View {
        VStack{
            Image(pet.pic)
                .foregroundColor(.white)
                .background(Color.cyan.opacity(0.5))
                .frame(width: 230, height: 230)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(5)
            
            HStack{
                Text(pet.petname+"와 만난지")
                    .font(.system(size: 22).weight(.bold))
                    .foregroundColor(Color.black)
                Text(String(pet.count))
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.pink)
                Text("일")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color.black)
            }
            .padding(.horizontal,20)
            .padding(.vertical,15)
            
            Text(pet.sort+"  /  "+String(pet.age)+" 세")
                .font(.system(size: 19).weight(.medium))
                .foregroundColor(Color.black)
                .padding(.bottom,15)

        }
        .frame(width:280, height:420)
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

struct LabelTextField : View {
    var label: String
    @Binding var text: String
    
    var body: some View {
        HStack() {
            Text(label)
                .font(.system(size: 18).weight(.bold))
                .foregroundColor(Color.black)
             Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.1))
                HStack {
                    TextField("", text: $text)
                        .padding(.leading,10)
                }
                .foregroundColor(Color.black)
             }
            .frame(width:200, height: 40)
            .cornerRadius(13)
         }
    }
}

struct ContentView : View {
    @State var petname: String = ""
    @State var sort: String = ""
    @State var age : String = ""
    @State var count : Date = Date()
    @State var pic: String = ""
    
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
                                .padding(.bottom,25)
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
                            }
                        }
                    }
                
            }
            
            VStack(alignment: .center) {
                LabelTextField(label: "이름",text: $petname)
                LabelTextField(label: "종",text: $sort)
                LabelTextField(label: "나이",text: $age)
                HStack(){
                    Text("만난 날")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundColor(Color.black)
                    Spacer()
                    DatePicker("날짜", selection: $count,displayedComponents: .date)
                        .frame(width: 200)
                        .padding(4)
                        .labelsHidden()
                        .datePickerStyle(.automatic)
                }
                
            }
            
        }.frame(width:270, height:420)
        
    }

    
}

struct MypageView: View{
    @State var selectedId:Int = 1
    @State var isEdit:Bool = false
    @State var petList: [Pet] = [
        Pet(petid : 1,
            petname :"몽글이",
            pic: "PetSample",
            sort : "시츄",
            age : 5,
            count: 200
        ),
        Pet(petid : 2,
            petname :"초코",
            pic: "PetSample",
            sort : "푸들",
            age : 2,
            count: 100
        ),
        Pet(petid : 3,
            petname :"두부",
            pic: "PetSample",
            sort : "포메",
            age : 5,
            count: 200
        )
    ]
    var body: some View{
        NavigationView{
            VStack{
                VStack{
                    HStack{
                        Text("마이페이지")
                            .font(.system(size: 20).weight(.bold))
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .padding(.vertical, 18)
                    .padding(.horizontal, 28)
                    
                    VStack {
                    }
                    .frame(width: 1000, height:8)
                    .background(Color.gray.opacity(0.2))
                    .border(Color.gray.opacity(0.3))
                    
                    HStack{
                        Text("몽글이")
                            .font(.system(size: 20).weight(.bold))
                            .foregroundColor(Color.black)
                        Text("님 반갑습니다!")
                            .font(.system(size: 18).weight(.bold))
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 28)
                    
                    Divider()
                    
                    HStack{
                        Image("MypetIcon")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                        Text("나의 PET !")
                            .font(.system(size: 20).weight(.bold))
                            .foregroundColor(Color.black)
                            .padding(.horizontal,5)
                        Spacer()
                        
                        Button(action: {
                            isEdit = !isEdit
                        }){
                            
                            Text(isEdit ? "완료":"추가")
                                .font(.system(size: 15).weight(.medium))
                                .foregroundColor(ColorManager.GreyColor)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 16)
                                .cornerRadius(50)
                                .background(RoundedRectangle(cornerRadius: 4, style: .continuous).fill(Color.gray.opacity(0.2)))
                            
                        }
                    }
                    .padding(.top, 14)
                    .padding(.horizontal, 28)
                    
                    
                    // scroll
                    if(!isEdit){
                        HStack(alignment: .center) {
                            ForEach(petList,id: \.self) { pet in
                                Profile(pet: pet)
                            }
                        }.modifier(ScrollingHStackModifier(items: petList.count, itemWidth: 280, itemSpacing: 10))
                    }
                    else{
                        ContentView()
                    }
                    
                    VStack {
                    }
                    .frame(width: 1000, height:8)
                    .background(Color.gray.opacity(0.2))
                    .border(Color.gray.opacity(0.3))
                    
                    
                    List{
                    
                        Text("내가 쓴 글")
                            .font(.system(size: 19).weight(.bold))
                            .foregroundColor(Color.black)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 28)
                        Divider()
                        
                        Text("좋아요 누른 글")
                            .font(.system(size: 19).weight(.bold))
                            .foregroundColor(Color.black)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 28)
                        Divider()
                        
                        Text("로그아웃")
                            .font(.system(size: 19).weight(.bold))
                            .foregroundColor(Color.black)
                            .padding(.vertical, 11)
                            .padding(.horizontal, 28)
                        Divider()
                        
                    }
                    
                    
                }
            }
        }
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
    }
}
