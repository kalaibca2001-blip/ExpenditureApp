//
//  HomeView.swift
//  ExpenditureApp
//
//  Created by VC on 04/07/26.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var store: ExpenseStore
    
    var body: some View {
        
        VStack {

            Text("Manage your expense")

            if store.expenses.isEmpty {

                Image("budget")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 550)
                    .padding(.top, 20)

            } else {

                Text("Expense Records")
                    .font(.title2)
                    .bold()

                VStack(spacing: 12) {

                    HStack {

                        Text("S.No")
                            .frame(width: 40)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(8)

                        Text("Expense")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(8)

                        Text("Amount")
                            .frame(width: 80)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(8)

                        Text("Edit")
                            .frame(width: 50)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(8)

                        Text("Delete")
                            .frame(width: 60)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .font(.headline)
                }
                ForEach(store.expenses.indices, id: \.self) { index in

                    HStack {

                        Text("\(index + 1)")
                            .frame(width: 40)

                        Text(store.expenses[index].name)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("₹\(store.expenses[index].amount)")
                            .frame(width: 80)

                        Button {

                        } label: {
//                            Text("edit")
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.blue)
                        }
                        .frame(width: 50)

                        Button {

                        } label: {
//                            Text("delete")
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .frame(width: 60)
                    }

                    
                }
                .padding()
                .background(Color.white.opacity(0.85))
                .cornerRadius(10)
            }

            Spacer()

            NavigationLink {
                Page2View(store: store)
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .background(
                        Circle()
                            .fill(Color.blue)
                            .shadow(radius: 8)
                    )
            }

        }
        .padding(.top, 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.45),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
            
            
        }
    }
    

    #Preview {
        HomeView(store: ExpenseStore())
    }
