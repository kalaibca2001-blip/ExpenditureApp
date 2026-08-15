import SwiftUI

struct LoadMoreDatesView: View {

    @State private var fromDate = Date()
    @State private var toDate = Date()

    @State private var showCalendar = false
    @State private var isSelectingFromDate = true
    @State private var tempSelectedDate = Date()
    
    @State private var filteredDates: [Date] = []

    @State private var showAlert = false
    @State private var alertMessage = ""

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

                //  From Date

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

                //  To Date

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

                // Info

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

                
                Button {

                    let calendar = Calendar.current

                    let from = calendar.startOfDay(for: fromDate)
                    let to = calendar.startOfDay(for: toDate)

                    // Check whether To Date is before From Date

                    if to < from {

                        alertMessage = "To Date cannot be earlier than From Date."
                        showAlert = true
                        return
                    }

                    // Calculate number of days

                    let days = calendar.dateComponents([.day], from: from, to: to).day ?? 0

                    // Maximum 10 days

                    if days > 9 {

                        alertMessage = "You can browse only a maximum of 10 days."
                        showAlert = true
                        return
                    }

                    filteredDates = CoreDataManager.shared.fetchTransactionDates(
                        from: fromDate,
                        to: toDate
                    )

                    if filteredDates.isEmpty {

                        alertMessage = "No transactions found for the selected date range."
                        showAlert = true
                    }

                } label: {

                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 35)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity)
                
             
                
                //  Browse by Date

                Text("Browse by Date")
                    .font(.headline)

                if !filteredDates.isEmpty {

                    VStack(spacing: 15) {

                        ForEach(filteredDates, id: \.self) { date in

                            NavigationLink {

                                DateWiseTransactionView(selectedDate: date)

                            } label: {

                                VStack(alignment: .leading, spacing: 8) {

                                    Text(date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    HStack {

                                        Text(date.formatted(.dateTime.weekday(.wide)))
                                            .font(.subheadline)
                                            .foregroundColor(.gray)

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }

                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.08), radius: 8)
                            }
                            .buttonStyle(.plain)

                        }

                    }
                }

                Spacer()

            }
            .padding()
            .navigationTitle("Load More Dates")
            .navigationBarTitleDisplayMode(.inline)

            //  Floating Calendar

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
        .alert("Invalid Selection", isPresented: $showAlert) {

            Button("OK", role: .cancel) { }

        } message: {

            Text(alertMessage)
        }
    }
}

#Preview {
    NavigationStack {
        LoadMoreDatesView()
    }
}
