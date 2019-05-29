import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:Biconik/main.dart';
import 'package:Biconik/widgets/button_buy.dart';

class ProductPage extends StatefulWidget {
  final String id;
  final String img;
  final String descrip;
  final int price;

  ProductPage(
      {Key key,
      @required this.id,
      @required this.img,
      @required this.descrip,
      @required this.price})
      : super(key: key);

  @override
  _ProductPageState createState() =>
      _ProductPageState(this.id, this.img, this.descrip, this.price);
}

class _ProductPageState extends State<ProductPage> {
  // Map<String, dynamic> data;
  // Map<String, dynamic> productData;
  String textId = "";
  String textImg = "";
  String textDescrip = "";
  int intPrice = 0;

  _ProductPageState(this.textId, this.textImg, this.textDescrip, this.intPrice);

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final cantController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getProduct(this.textId);
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(this.textId);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Comprar producto'),
      ),
      body: ListView(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(this.textImg),
            maxRadius: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Precio: \$" + this.intPrice.toString() + '.00',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Descripcion:' + this.textDescrip,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Correo:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Ingrese su correo'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Nombres:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Ingrese sus nombres'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Apellidos:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(labelText: 'Ingrese sus apellidos'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Dirección:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Ingrese su dirección'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Ciudad:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: cityController,
            decoration:
                InputDecoration(labelText: 'Ingrese la ciudad de envio'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Estado:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: stateController,
            decoration: InputDecoration(labelText: 'Ingrese el estado'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Código postal:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: postalCodeController,
            decoration: InputDecoration(
                labelText: 'Ingrese el código postal de su regíon'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Tarjeta:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: cardNumberController,
            decoration:
                InputDecoration(labelText: 'Ingrese el número de tarjeta'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Codigo de seguridad:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          TextFormField(
            controller: cvvController,
            decoration: InputDecoration(labelText: 'Ingrese su cvv'),
          ),
          RaisedButton(
            // tooltip: 'Show me the value!',
            padding: const EdgeInsets.all(12.0),
            child: ButtonPersonal('Comprar'),
            onPressed: () {
              buyProduct();
            },
          ),
        ],
      ),
    );
  }

  buyProduct() async {
    Post newPost = new Post(
        email: emailController.text,
        name: nameController.text,
        lastname: lastNameController.text,
        address: addressController.text,
        product: this.textId,
        cant: cantController.text,
        city: cityController.text,
        state: stateController.text,
        zipCode: postalCodeController.text,
        cardNumber: cardNumberController.text,
        cvv: cvvController.text);
    Post p = await createPost('http://178.128.14.222/BackMEAN/api/orders',
        body: newPost.toMap());

    if (p.email == 'Insert succesfully') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Error al comprar vuelve a intentarlo'),
          );
        },
      );
    }
    // debugPrint(p.mail);

    // return showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text(this.textId),
    //     );
    //   },
    // );
  }

  // getProduct(_id) async {
  //   http.Response response =
  //       await http.get('http://178.128.14.222/BackMEAN/api/products/${_id}');
  //   data = jsonDecode(response.body);
  //   setState(() {
  //     productData = data['product'];
  //   });
  // }
}

class Post {
  final String email;
  final String name;
  final String lastname;
  final String address;
  final String product;
  final String cant;
  final String city;
  final String state;
  final String zipCode;
  final String cardNumber;
  final String cvv;

  Post(
      {this.email,
      this.name,
      this.lastname,
      this.address,
      this.product,
      this.cant,
      this.city,
      this.state,
      this.zipCode,
      this.cardNumber,
      this.cvv});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(email: json['message']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['name'] = name;
    map['lastname'] = lastname;
    map['address'] = address;
    map['product'] = product;
    map['cant'] = cant;
    map['city'] = city;
    map['state'] = state;
    map['zipCode'] = zipCode;
    map['cardNumber'] = cardNumber;
    map['cvv'] = cvv;

    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
