import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp/domain/entities/contact_entity.dart';
import 'package:whatsapp/domain/entities/user_entity.dart';
import 'package:whatsapp/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:whatsapp/presentation/bloc/user/user_cubit.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class SelectContactPage extends StatefulWidget {
  final UserEntity? userInfo;

  const SelectContactPage({Key? key, this.userInfo}) : super(key: key);

  @override
  _SelectContactPageState createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  @override
  void initState() {
    BlocProvider.of<GetDeviceNumbersCubit>(context).getDeviceNumbers(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDeviceNumbersCubit, GetDeviceNumbersState>(
      builder: (context, contactNumberState) {
        if (contactNumberState is GetDeviceNumbersLoaded) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              if (userState is UserLoaded) {
                final List<ContactEntity> contacts = [];
                final dbUsers = userState.users
                    .where((user) => user.uid != widget.userInfo!.uid)
                    .toList();
                contactNumberState.contacts!.forEach((deviceUserNumber) {
                  dbUsers.forEach(
                    (dbUser) {
                      if (dbUser.phoneNumber ==
                          deviceUserNumber.phoneNumber!
                              .replaceAll(' ', '')
                              .replaceAll('-', '')) {
                        contacts.add(ContactEntity(
                          label: dbUser.name,
                          phoneNumber: dbUser.phoneNumber,
                          uid: dbUser.uid,
                          status: dbUser.status,
                        ));
                      }
                    },
                  );
                });
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Contact",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "${contacts.length} contacts",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    actions: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),
                  body: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        _newGroupButtonWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        _newContactButtonWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        _listContact(contacts),
                      ],
                    ),
                  ),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _newGroupButtonWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: lightPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "New Group",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _newContactButtonWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: lightPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "New contact",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(
            FontAwesomeIcons.qrcode,
            color: lightPrimaryColor,
          )
        ],
      ),
    );
  }

  Widget _listContact(List<ContactEntity> contacts) {
    return Expanded(
      child: ListView.separated(
        itemCount: contacts.length,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Divider(
              height: 1,
            ),
          );
        },
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 10, left: 2),
              child: ListTile(
                contentPadding: EdgeInsets.only(
                  left: 0,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: Image.asset(
                    "assets/profile_default.png",
                    width: 45,
                    height: 45,
                  ),
                ),
                title: Text("${contacts[index].label}"),
                subtitle: Text("Hey there! I am Using WhatsApp."),
              ),
            ),
          );
        },
      ),
    );
  }
}
