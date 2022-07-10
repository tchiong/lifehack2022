# kindness_network

A mobile app aiming to serve as a platform for volunteers and beneficiaries.

## Getting Started

We provide the apk build file which can be ran on any android device or emulator. 
Alternatively, if you have flutter installed, you may run the main.dart file with an android emulator.

### Setting up using the apk

Download the apk file to an android emulator or android phone and install the app. 

### Setting up using flutter

You will require flutter v3.0.4, connect your android emulator/device and run the main.dart file.

## Test Accounts

Since we are unable to get approval to connect to singpass for login during the duration of this competition, we provide two test accounts for beneficiaries and one for volunteers.

After clicking log in, choose either volunteer or beneficiary and you will enter the singpass login screen. Below the singpass QR code, you will see some buttons to log in as test accounts. 

## Usage

Using the beneficiary accounts, one can create a new request, view pending requests that have been created and past requests that have been completed. When completing a request, feedback can be made by 
the beneficiary

Using the volunteer account, one can view unaccepted, pending and completed requests and accept requests.

# Note
With regards to the language, we intend to offer the feature to beneficiaries and volunteers alike, however, with the duration of the competition, there was not enough time for translation.

With regards to showing volunteer and beneficiary names, since the future implementation of the app intends to use singpass to get this info, we currently pass user id around instead, therefore users are represented by numbers.

Beneficiary Account 1 -> 0
Beneficiary Account 2 -> 1
Volunteer Account 1 -> 2

