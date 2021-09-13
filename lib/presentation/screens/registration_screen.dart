import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsapp/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp/presentation/pages/phone_verification_page.dart';
import 'package:whatsapp/presentation/pages/set_initial_profile_page.dart';
import 'package:whatsapp/presentation/screens/home_screen.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("7");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber = "";

  TextEditingController _phoneAuthController = TextEditingController();

  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          builder: (context, phoneAuthState) {
        if (phoneAuthState is PhoneAuthSmsCodeReceived) {
          return PhoneVerificationPage(
            phoneNumber: _phoneNumber,
          );
        }
        if (phoneAuthState is PhoneAuthProfileInfo) {
          return SetInitialProfilePage(
            phoneNumber: _phoneNumber,
          );
        }
        if (phoneAuthState is PhoneAuthLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (phoneAuthState is PhoneAuthSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
            if (authState is Authenticated) {
              return HomeScreen(uid: authState.uid);
            }
            return Container();
          });
        }
        return _bodyWidget();
      }, listener: (context, phoneAuthState) {
        if (phoneAuthState is PhoneAuthSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (phoneAuthState is PhoneAuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Something is wrong"), Icon(Icons.error_outline)],
              ),
            ),
          ));
        }
      }),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Verify your phone number",
                    style: TextStyle(
                        color: lightPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.more_vert)
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "WhatsApp will send an SMS message (carrier charges may apply) to verify your phone number. Enter your country code and phone number:",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                onTap: _openFilteredCountryPickerDialog,
                title: _buildDialogItem(_selectedFilteredDialogCountry),
              ),
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1.50,
                      color: lightPrimaryColor,
                    ))),
                    width: 80,
                    height: 42,
                    alignment: Alignment.center,
                    child: Text("${_selectedFilteredDialogCountry.phoneCode}"),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextField(
                        controller: _phoneAuthController,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: lightPrimaryColor, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    color: lightPrimaryColor,
                    onPressed: () {
                      _submitVerifyPhoneNumber();
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
              data: Theme.of(context).copyWith(
                primaryColor: lightPrimaryColor,
              ),
              child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.black,
                searchInputDecoration: InputDecoration(
                  hintText: "Search",
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: lightPrimaryColor, width: 2.0),
                  ),
                ),
                isSearchable: true,
                title: Text("Select your phone code"),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedFilteredDialogCountry = country;
                    _countryCode = country.phoneCode;
                  });
                },
                itemBuilder: _buildDialogItem,
              ),
            ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}"),
          SizedBox(
            width: 8.0,
          ),
          Flexible(
              child: Text(
            "${country.name}",
            overflow: TextOverflow.ellipsis,
          )),
        ],
      ),
    );
  }

  void _submitVerifyPhoneNumber() {
    if (_phoneAuthController.text.isNotEmpty) {
      _phoneNumber = "+$_countryCode${_phoneAuthController.text}";
      BlocProvider.of<PhoneAuthCubit>(context).submitVerifyPhoneNumber(
        phoneNumber: _phoneNumber,
      );
    }
  }
}
