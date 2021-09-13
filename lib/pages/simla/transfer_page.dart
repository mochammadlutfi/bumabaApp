import 'package:bumaba/config/app_theme.dart';
import 'package:bumaba/controllers/simla_controller.dart';
import 'package:bumaba/models/contact_model.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Config/color.dart';

class SimlaTransferPage extends StatefulWidget {
  final RouteArgument routeArgument;

  SimlaTransferPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _SimlaTransferPageState createState() {
    return _SimlaTransferPageState();
  }
}

class _SimlaTransferPageState extends StateMVC<SimlaTransferPage> {
  SimlaController _con;
  List<AppContact> contacts = [];
  List<AppContact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();
  bool contactsLoaded = false;

  _SimlaTransferPageState() : super(SimlaController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    // _fetchContacts();
    getPermissions();
  }
  
  getPermissions() async {
    if (await FlutterContacts.requestPermission()) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }
  
  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<AppContact> _contacts = (await FlutterContacts.getContacts(withProperties: true, withThumbnail: true)).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      return new AppContact(info: contact, color: baseColor);
    }).toList();
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  filterContacts() {
    List<AppContact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.info.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.info.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.number);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist = (
        (isSearching == true && contactsFiltered.length > 0) ||
        (isSearching != true && contacts.length > 0)
    );
    ThemeData themeData = Theme.of(context);
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.customTheme.bgLayer1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
          ),
        ),
        title: Text("Tujuan Transfer",
            style: AppTheme.getTextStyle(
                themeData.textTheme.headline6,
                fontWeight: 700)
        ),
      ),
      key: _con.scaffoldKey,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color : AppTheme.customTheme.bgLayer1,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: searchController,
                  style: TextStyle(
                    fontSize: 14.0, 
                  ),
                  decoration: InputDecoration(
                    hintText: 'Cari No Ponsel/Nama',
                    fillColor: bodylight,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    prefixIcon: Icon(
                      Icons.search,
                      color: blacktext,
                      size: 20.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: blacktext,
                      ),
                      onPressed: () {
                        searchController.clear();
                      }
                    ),
                  ),
                ),
              ),
            ),
            contactsLoaded == true ?  // if the contacts have not been loaded yet
              listItemsExist == true ?  // if we have contacts to show
              ContactsList(
                ontap : (value) {
                  // print(value);
                  _con.validateAnggota(value['phone'], value['avatar']);
                },
                reloadContacts: () {
                  getAllContacts();
                },
                contacts: isSearching == true ? contactsFiltered : contacts,
              )
              : Container(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  isSearching ? 'No search results to show' : 'No contacts exist',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                )
              ) :
            Container(  // still loading contacts
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ContactsList extends StatelessWidget {
  final List<AppContact> contacts;
  Function() reloadContacts;
  ValueSetter<Map> ontap = (value) {}; 
  ContactsList({Key key, this.contacts, this.reloadContacts, this.ontap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          AppContact contact = contacts[index];
          return ListTile(
            onTap: () => ontap({
              'phone' : contact.info.phones.first.normalizedNumber,
              'avatar' : contact.info.name.last.isEmpty ? contact.info.name.first[0] : contact.info.name.first[0]+contact.info.name.last[0]
            }),
            title: Text(contact.info.displayName),
            subtitle: Text(
                contact.info.phones.isNotEmpty ? contact.info.phones.first.normalizedNumber : '' 
            ),
            leading: ContactAvatar(contact, 36)
          );
        },
      ),
    );
  }
}

class ContactAvatar extends StatelessWidget {
  ContactAvatar(this.contact, this.size);
  final AppContact contact;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mainColor
        ),
        child: CircleAvatar(
          child: Text(contact.info.name.last.isEmpty ? contact.info.name.first[0] : contact.info.name.first[0]+contact.info.name.last[0],
            style: TextStyle(color: Colors.white)
          ),
          backgroundColor: Colors.transparent
        )
    );
  }
}