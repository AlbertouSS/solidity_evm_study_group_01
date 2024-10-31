// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

// msg.sender es una variable global, es decir; está disponible en todo momento

contract Ejemplo {

    // function quienSoy() public view returns (address) {
    //         address myDireccion = msg.sender;
    //         // retorna la direccion que llama a la funcion
    //         return myDireccion;
    // }

/********************** RECUERDAN EL EJEMPLO DEL TOKEN? *********************************/

    address public duenoDelContrato = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    mapping(address => uint256) public balances;

    function asignarBalance(address usuario, uint256 cantidad) public {
        if (msg.sender == duenoDelContrato)
            {balances[usuario] = cantidad;}
    }

    function transferirTokensEntreUsuarios(address destinatario, uint256 cantidad) 
        public {
            balances[msg.sender] -= cantidad;   // deduct/debit the sender's balance
            balances[destinatario] += cantidad; // credit the reciever's balance
    }
}