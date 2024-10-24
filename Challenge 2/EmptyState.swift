//
//  EmptyState.swift
//  Challenge 2
//
//  Created by E07 on 16/04/1446 AH.
//

import SwiftUI

struct EmptyState: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
                
                HStack {
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.buttonBG)
                                .position(x: 350, y:80)
                                .padding(.leading)
                            
                            Image(systemName: "plus")
                                .padding(.trailing)
                                .frame(maxWidth: .infinity, alignment:.bottomTrailing)
                                .foregroundColor(Color( red: 212 / 255, green: 200 / 255, blue: 255 / 255))
                                .font(.system(size: 22))
                                .position(x: 303, y: 80)
                        }
                    }
                    .padding(.leading)
                    
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.buttonBG)
                                .position(x: 106, y:80)
                                .padding(.leading)
                            
                            Image(systemName: "line.3.horizontal.decrease")
                                .padding(.trailing)
                                .frame(maxWidth: .infinity, alignment:.bottomTrailing)
                                .foregroundColor(Color( red: 212 / 255, green: 200 / 255, blue: 255 / 255))
                                .font(.system(size: 21))
                                .position(x: 61, y: 80)
                        }
                    }
                    .padding(.leading)
                    
                }
                
            VStack {
                
            
                Text("Journal")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .font(.system(size: 34))
                    .position(x: 85, y: 80)
                
                Image("NoteBook")
                    .resizable()
                    .frame(width: 77.7, height:  101)
                    .padding(.bottom, 20)
                
                Text("Begin Your Journal")
                    .fontWeight(.bold)
                    .foregroundColor(Color( red: 212 / 255, green: 200 / 255, blue: 255 / 255))
                    .font(.system(size: 24))
                    .padding(.bottom, 350)
                
                Text("Craft your personal diary, tap the plus icon to begin")
                    .frame(width: 270, height: 100 )
                    .fontWeight(.light)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.top, -375)
            }

        }
    }
}

#Preview {
    EmptyState()
}
