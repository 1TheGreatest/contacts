/*
 * Copyright 2018 Harsh Sharma
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/utils/constants.dart';

class ContactPage extends StatefulWidget {
  final List<Contact> contactList;

  ContactPage({this.contactList});

  @override
  createState() => new ContactPageState(contactList: contactList);
}

class ContactPageState extends State<ContactPage> {
  List<Contact> contactList;

  ContactPageState({this.contactList});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: loadList(contactList),
      backgroundColor: Colors.grey[150],
    );
  }

  Widget loadList(List<Contact> list) {
    if (list != null) {
      return _buildContactList(list);
    } else {
      return new Container(
        height: double.infinity,
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.account_circle,
              color: Colors.blue[400],
              size: 150.0,
            ),
            new Container(
              child: new Text(
                Texts.NO_CONTACTS,
                style:
                    new TextStyle(fontSize: 26.0, color: Colors.blueGrey[400]),
              ),
              margin: EdgeInsets.only(top: 5.0),
            )
          ],
        ),
      );
    }
  }

  Widget _buildContactList(List<Contact> birthdays) {
    return new ListView.builder(
//      padding: const EdgeInsets.only(
//          top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildContactRow(birthdays[i]);
      },
      itemCount: birthdays.length,
    );
  }

  Widget _buildContactRow(Contact contact) {
    return new Card(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                contactImage(contact),
                contactDetails(contact)
              ],
            ),
            new Container(
              margin: EdgeInsets.only(top: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  actionContainer(
                      Icons.visibility, Colors.blue[400], Actions.VIEW_CONTACT),
                  actionContainer(
                      Icons.edit, Colors.blueGrey[400], Actions.VIEW_CONTACT),
                  actionContainer(
                      Icons.delete, Colors.black, Actions.VIEW_CONTACT),
                ],
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget contactImage(Contact contact) {
    return new Image.memory(
      base64.decode(contact.contactImage),
      height: 100.0,
      width: 100.0,
      fit: BoxFit.fill,
    );
  }

  Widget contactDetails(Contact contact) {
    return new Flexible(
        child: new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          textContainer(contact.name, Colors.blue[400]),
          textContainer(contact.phone, Colors.blueGrey[400]),
          textContainer(contact.email, Colors.black),
        ],
      ),
      margin: EdgeInsets.only(left: 20.0),
    ));
  }

  Widget textContainer(String string, Color color) {
    return new Container(
      child: new Text(
        string,
        style: TextStyle(
            color: color, fontWeight: FontWeight.normal, fontSize: 16.0),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }

  Widget actionContainer(IconData icon, Color color, String action) {
    return new Flexible(
        flex: 1,
        child: new GestureDetector(
          child: new Icon(
            icon,
            size: 30.0,
            color: color,
          ),
          onTap: () {
            setState(() {
              switch (action) {
                case Actions.VIEW_CONTACT:
                  break;
                case Actions.EDIT_OR_UPDATE_CONTACT:
                  break;
                case Actions.DELETE_CONTACT:
                  break;
              }
            });
          },
        ));
  }
}
