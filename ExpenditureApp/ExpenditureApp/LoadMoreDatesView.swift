import SwiftUI

struct LoadMoreDatesView: View {

    @State private var fromDate = Date()
    @State private var toDate = Date()

    @State private var showCalendar = false
    @State private var isSelectingFromDate = true
    @State private var tempSelectedDate = Date()

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color.blue.opacity(0.18),
                    Color.green.opacity(0.18),
                    Color.white
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {

                // MARK: - From Date

                Text("From Date")
                    .font(.headline)

                HStack {

                    Text(fromDate.formatted(date: .numeric, time: .omitted))

                    Spacer()

                    Button {

                        isSelectingFromDate = true
                        tempSelectedDate = fromDate
                        showCalendar = true

                    } label: {

                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }

                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )

                // MARK: - To Date

                Text("To Date")
                    .font(.headline)

                HStack {

                    Text(toDate.formatted(date: .numeric, time: .omitted))

                    Spacer()

                    Button {

                        isSelectingFromDate = false
                        tempSelectedDate = toDate
                        showCalendar = true

                    } label: {

                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }

                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )

                // MARK: - Info

                HStack(spacing: 12) {

                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)

                    Text("You can view data for maximum 10 days only.")
                        .font(.subheadline)

                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue.opacity(0.12))
                .cornerRadius(12)

                // MARK: - Browse by Date

                Text("Browse by Date")
                    .font(.headline)

                Spacer()

            }
            .padding()
            .navigationTitle("Load More Dates")
            .navigationBarTitleDisplayMode(.inline)

            // MARK: - Floating Calendar

            if showCalendar {

                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showCalendar = false
                    }

                VStack {

                    DatePicker(
                        "",
                        selection: $tempSelectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .onChange(of: tempSelectedDate) { _, newDate in

                        if isSelectingFromDate {
                            fromDate = newDate
                        } else {
                            toDate = newDate
                        }

                        showCalendar = false
                    }
                    .frame(width: 320)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .shadow(color: .black.opacity(0.25), radius: 12)

                }
            }

        }
    }
}

#Preview {
    NavigationStack {
        LoadMoreDatesView()
    }
}
