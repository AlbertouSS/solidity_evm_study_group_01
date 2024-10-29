// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

// Cadenas o Strings
contract StringsContract {

    function eco(string calldata input) // siempre se usa calldata cuando la cadena se usa como argumento
        public 
        pure 
        returns (string memory) { //para retornar una cadena se usa memory junto con el tipo string
            return input; // devuelve lo mismo que lo que entra (por eso es eco)
    }

    function saludar() // no hay argumentos
        public 
        pure 
        returns (string memory) {
            string memory saludo = "Hola son las 7 pm"; // una cadena se declara como: string memory
            return saludo; // devuelve lo mismo que lo que entra
    }

    function juntarCadenas(string calldata cadena1, string calldata cadena2)
        public
        pure 
        // returns (string memory){
        //     string memory cadena = string.concat(cadena1, cadena2);
        //     return cadena;
        // }
        returns (string memory unaSolaCadena){ // declaramos la variable que vamos a retornar
            unaSolaCadena = string.concat(cadena1, cadena2); // retorno implicito de la variable
        }
}