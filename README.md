# Expenditure App

Expenditure App is an iOS application designed to help users manage and track their income and expenses in one place.

## Features

- User Sign Up and Login
- Form validation for user registration
- Secure credential storage using Keychain
- Add income and expense transactions
- Edit and delete transactions
- Total income calculation
- Total expense calculation
- Current balance calculation
- Recent activity display
- Browse transactions by date
- Load more dates with date-range filtering
- Local data persistence using Core Data

## Technologies Used

- Swift
- SwiftUI
- Core Data
- Keychain
- Xcode
- MVC / MVVM

## Architecture

The application follows a structured architecture using MVC and MVVM concepts to keep the code organized and maintainable.

## Data Storage

- **Core Data** – Used to store income and expense transaction data locally.
- **Keychain** – Used to securely store user account credentials.

## Main Screens

### Login
Users can log in using their registered email and password.

### Sign Up
New users can create an account with name, email, password, and password confirmation validation.

### Overview
The home screen displays:

- Total Expense
- Total Income
- Current Balance
- Recent Activity

### Add Transaction
Users can add income and expense records with the required transaction details.

### Load More Dates
Users can browse transactions based on a selected date range.


## Developer

**Kalaivani Velayutham**

iOS Developer | Swift & SwiftUI

