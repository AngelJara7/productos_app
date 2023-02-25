import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(),
            _ProductDetails(),
            Positioned(
              top: 0,
              right: 0,
              child: _priceTag()
            ),
            Positioned(
              top: 0,
              left: 0,
              child: _notAvailable()
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10
      )
    ]
  );
}

class _BackgroundImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.red,
        child: const FadeInImage(
          placeholder: AssetImage("assets/jar-loading.gif"), 
          image: NetworkImage("https://via.placeholder.com/400x300/f6f6f6"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Disco duro G", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            ),
            Text("Id del disco duro", style: TextStyle(fontSize: 15, color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _priceTag extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("\$100.99", style: TextStyle(color: Colors.white, fontSize: 20),)
        ),
      ),
    );
  }
}

class _notAvailable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("No disponible", style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}