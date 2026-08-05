//
//  TransactionRowView.swift
//  ExpenditureApp
//
//  Created by VC on 30/07/26.
//
import SwiftUI

struct TransactionRowView: View {

    var sno: String
    var title: String
    var typeIcon: String
    var typeColor: Color
    var amount: String
    var onEdit: () -> Void
    var onDelete: () -> Void

    var body: some View {

        VStack(spacing: 0) {

            HStack(spacing: 0) {

                Text(sno)
                    .frame(width: 50)

                Divider()

                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)

                Divider()

                Image(systemName: typeIcon)
                    .foregroundColor(typeColor)
                    .frame(width: 60)

                Divider()

                Text(amount)
                    .frame(width: 90)

                Divider()

                HStack(spacing: 12) {

                    Button {

                        onEdit()

                    } label: {

                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.blue)
                    }

                    Button {

                        onDelete()

                    } label: {

                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }

                }
                .frame(width: 90)

            }
            .frame(height: 45)

            Divider()
        }
    }
}

#Preview {
    TransactionRowView(
        sno: "1",
        title: "Lunch",
        typeIcon: "chart.line.downtrend.xyaxis",
        typeColor: .red,
        amount: "₹250",
        onEdit: {},
        onDelete: {}
    )
}
