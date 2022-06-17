//
//  MainView.swift
//  LoginPage
//
//  Created by Andres Machado on 3/30/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var selectedIndex = 0
    
    let icons = [
        "house",
        "list.dash",
        "person"
    ]
    
    var body: some View {
        VStack {
            //Content
            ZStack {
                switch selectedIndex {
                case 0:
                    NavigationView {
                        VideoListView()
                        } .navigationBarTitle("Discover🔎", displayMode: .inline)
                    case 1:
                    GameListView() 
                default:
                    AccountView()
                }
            }
            
            Spacer()
            
            Divider()
            HStack{
                ForEach(0..<3, id: \.self) { number in
                    Spacer()
                    Button(action: {
                        self.selectedIndex = number
                    }, label: {
                        if number == 2 {
                            Image(systemName: icons[number])
                                .font(.system(size: 25,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(selectedIndex == number ? Color(.label) : Color(UIColor.lightGray))
                            
                        }
                        else {
                            Image(systemName: icons[number])
                                .font(.system(size: 25,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(selectedIndex == number ? Color(.label) : Color(UIColor.lightGray))
                        }
                    })
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

